Plugins in jenkins server
=========================

Deploy to container*
===================

--> Deploy the our application into the tomcat server 


maven integration
==================

if you want to create a maven project type then use this plugin.





safeRestart
===========

systemctl restart jenkins ---> It is in linux server, But we dont have permission to access it , Then how to restart it.


restart --->http://65.0.199.60:8080/restart

safeRestart -->http://65.0.199.60:8080/safeRestart

IQ] what is the difference between restart and safeRestart ?

restart: It will stop the running jobs and then restarted

safeRestart: It will wait for complition of all the jobs and restarted


NOTE: for safeRestart we have plugin called as a safeRestart, Install and try it



Q] How to delete the particular build? Suppose we want to delete #21











next Build Number
=================

--> After insatlling this plugin we can give our own build number, The next number must be greater than the previous build number only.

NOTE: in linux server /var/lib/jenkins/jobs/jio-dev/jobs/nextBuildNumber file is available , But some time times we dont have an access to linux server to use this





JaCoCo
======

By using this plugin we can stop the deployment through code coverage percentage.


ssh agent 
=========
we will discuss in the pipeline project

Audit Trail ***
===========

I will help us to track the jenkins activity like create,delete jobs, etc

--> install the plugin

--> dashboard --> manage jenkins --> system --> audit trail --> add logger --> log file --> log rotation: /var/lib/jenkins/audit-trail.log
    size in MB: 20
    Log file count: 5



audit-trail.log.0 --> 20 MB 

audit-trail.log.1 --> 20 MB

audit-trail.log.2 --> 20 MB

audit-trail.log.3 --> 20 MB

audit-trail.log.4 --> 20 MB








tail -f audit-trail.log.0  --> go and trigger the build








Blue ocean plugin
=================




Build name and Description setter
================================

step 1: Install plug-in

step 2 : Dash board --> job --> configuration --> Build Environment --> select Set Build Name --> jio-dev-#${BUILD_NUMBER}









Thin backup 
===========
will discuss in jenkins backup

Role based authentication
=========================
will discuss in jenkins security
