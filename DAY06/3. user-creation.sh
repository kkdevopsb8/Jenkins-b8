#!/bin/bash

# =========================================================
# Script Name : create_jenkins_users.sh
# Purpose     : Create 10 Jenkins internal users
# Requirement : Jenkins must use "Jenkins' own user database"
# Author      : Admin
# =========================================================

set -euo pipefail

# =========================
# Jenkins connection details
# =========================
JENKINS_URL="http://13.201.81.95:8080"
ADMIN_USER="kkfunda"
ADMIN_TOKEN="11477f74397ad5bf02a7205c5d5c934b14"

# =========================
# Default password for new users
# =========================
DEFAULT_PASSWORD="Welcome@123"

# =========================
# Temporary files
# =========================
COOKIE_FILE="/tmp/jenkins_cookie_$$.txt"
GROOVY_FILE="/tmp/create_jenkins_users_$$.groovy"
CRUMB_FILE="/tmp/jenkins_crumb_$$.txt"

cleanup() {
    rm -f "$COOKIE_FILE" "$GROOVY_FILE" "$CRUMB_FILE"
}
trap cleanup EXIT

# =========================
# Check curl
# =========================
if ! command -v curl >/dev/null 2>&1; then
    echo "[ERROR] curl is not installed. Please install curl first."
    exit 1
fi

# =========================
# Build Groovy script
# =========================
cat > "$GROOVY_FILE" <<EOF
import jenkins.model.*
import hudson.security.*
import hudson.model.User

def instance = Jenkins.get()
def realm = instance.getSecurityRealm()

if (!(realm instanceof HudsonPrivateSecurityRealm)) {
    println "[ERROR] Jenkins is not using 'Jenkins\\' own user database'."
    return
}

def users = [
    [username: "devopsuser1",  password: "${DEFAULT_PASSWORD}", fullname: "DevOps User 1"],
    [username: "devopsuser2",  password: "${DEFAULT_PASSWORD}", fullname: "DevOps User 2"],
    [username: "builduser1",   password: "${DEFAULT_PASSWORD}", fullname: "Build User 1"],
    [username: "builduser2",   password: "${DEFAULT_PASSWORD}", fullname: "Build User 2"],
    [username: "releaseuser1", password: "${DEFAULT_PASSWORD}", fullname: "Release User 1"],
    [username: "releaseuser2", password: "${DEFAULT_PASSWORD}", fullname: "Release User 2"],
    [username: "qauser1",      password: "${DEFAULT_PASSWORD}", fullname: "QA User 1"],
    [username: "qauser2",      password: "${DEFAULT_PASSWORD}", fullname: "QA User 2"],
    [username: "deployuser1",  password: "${DEFAULT_PASSWORD}", fullname: "Deploy User 1"],
    [username: "monitoruser1", password: "${DEFAULT_PASSWORD}", fullname: "Monitor User 1"]
]

users.each { u ->
    def existing = User.getById(u.username, false)
    if (existing != null) {
        println "[INFO] User '\${u.username}' already exists. Skipping..."
    } else {
        def newUser = realm.createAccount(u.username, u.password)
        newUser.setFullName(u.fullname)
        newUser.save()
        println "[SUCCESS] User '\${u.username}' created successfully."
    }
}

println "[INFO] Jenkins internal user creation completed."
EOF

echo "========================================"
echo "Creating Jenkins internal users..."
echo "Jenkins URL: $JENKINS_URL"
echo "Admin User : $ADMIN_USER"
echo "========================================"

# =========================
# Get Jenkins crumb
# =========================
CRUMB_RESPONSE=$(curl -s -u "${ADMIN_USER}:${ADMIN_TOKEN}" \
    -c "$COOKIE_FILE" \
    "${JENKINS_URL}/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,\":\",//crumb)" || true)

if [[ -z "${CRUMB_RESPONSE}" ]]; then
    echo "[ERROR] Failed to get Jenkins crumb."
    echo "Check Jenkins URL, admin username, password/API token, and network access."
    exit 1
fi

echo "$CRUMB_RESPONSE" > "$CRUMB_FILE"

# =========================
# Execute Groovy via script console
# =========================
HTTP_CODE=$(curl -s -o /tmp/jenkins_user_create_output_$$.txt -w "%{http_code}" \
    -u "${ADMIN_USER}:${ADMIN_TOKEN}" \
    -b "$COOKIE_FILE" \
    -H "$(cat "$CRUMB_FILE")" \
    --data-urlencode "script=$(cat "$GROOVY_FILE")" \
    "${JENKINS_URL}/scriptText")

echo "========================================"
cat /tmp/jenkins_user_create_output_$$.txt
rm -f /tmp/jenkins_user_create_output_$$.txt
echo "========================================"

if [[ "$HTTP_CODE" == "200" ]]; then
    echo "[SUCCESS] Script executed successfully in Jenkins."
    echo "[INFO] Default password for created users: $DEFAULT_PASSWORD"
else
    echo "[ERROR] Jenkins returned HTTP status: $HTTP_CODE"
    exit 1
fi
