How to integrate with slack?
=============================

step 1: login slack.com

step 2: channels --> chanel --> create channel --> channel name --> next --> public --> create

step 3: 

    KK FUNDA --> Invite pople to kk funda --> copy invite link 

   https://join.slack.com/t/kkfunda/shared_invite/zt-2nxl4nw11-LipxXvOotWPmIIPjFgw


step 4: KK FUNDA --> tools and settings --> manage apps --> search with "jenkins ci" --> click on "Add to slack" --> select a channel --> Add jenkins ci integration --> 

https://kkfunda.slack.com/services/B08FJJN9ELX?added=1

step 5: install slack notification plugin in jenkins

step 6: manage jenkins --> configure systems --> slack --> workspace: kkfunda -->

   credentials: Add credentials --> Secret text --> paste the secret[lHCwhkIRdaeAqZlR] --> add the description

    default channel: #jio ---> Test connection --> save

step 7: 

select job --> configure --> scroll down to end --> post build actions --> select slack notifications 

--> select slack notifications --> advanced --> select options[enter the specific channel-id] --> save 

Build with parameters
======================

Dashboard --> job --> configuration --> General --> select This Project is parametirized --> add parameter --> choice parameter -->

   names: BranchNames
   Choices: main 
            dev
            qa
--> save 


NOTE: under the source code section pass the names 
    
      */${BranchNames}



How to create a view?
=====================


enable and diable the project(jobs)
====================================



