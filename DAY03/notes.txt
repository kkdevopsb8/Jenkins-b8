SCM Polling
============

1)Jenkins polls SCM based on a defined schedule

2)If new commits are found, the build is triggered.

Pros: Always builds the latest code changes
Cons: Frequent polling can use a lot of server resources.


Periodic Builds
===============

1)Jenkins builds at specified intervals, regardless of code changes,
 
2)You set a cron-like schedule for builds,Builds occur based on this schedule

Pros: Regular builds, independent of code changes.
Cons: May build the same code if no new commits exist



GitHub Webhook
==============

GitHub notifies Jenkins of code changes immediately.

Pros: Immediate build triggering, reducing lag.

Cons: Requires proper webhook configuration.

webhook congiguration
====================== 
 setup build config -> click -GitHub Webhook
Go to ->github ->select your repository  nd branch -> on right side click on settings->select webhooks -> payload block  fill the jenkins <url>http://65.1.95.162:8080/github-webhook/

nd select contextpath : json --> click addit














Code Coverage
=============
Tool: JaCoCo

Goal: Ensure code coverage is at least 80%.


1)Identify untested code using JaCoCo reports.

2)Write more tests for uncovered areas.

NOTE:Set Jenkins to fail builds if coverage is below 80%












discard old builds
===================

create an another job with same configuration of other job
==========================================================



Jenkins server stop and start issue
====================================

old: 52.66.196.163

new: 65.2.171.155


/var/lib/jenkins/jenkins.model.jenconf.xml   ---> update new ip here and restart jenkins
