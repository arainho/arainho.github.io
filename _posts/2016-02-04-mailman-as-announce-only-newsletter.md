---
layout: post
comments: true
title:  "MailMan as 'Announce Only' Newsletter"
date:   2016-02-04 19:24:00
categories: mailman announce ml newsletter
---


To create an "Announce Only" newsletter with Mailman, 
i follow these steps on [lunarpages] and it's works like a charm ;-) 


#### First, go to:

http://www.example.com/mailman/admin/yourlistname

yourlistname is your ML, 
(left of the @ symbol in the mailing list's email address)


#### 1. Privacy Options >> Subscription Rules

    Who can view subscription list? (List admin only)


#### 2. Privacy Options >> Sender Filters

    By default, should new list member postings be moderated? (Yes)
    Action to take when a moderated member posts to the list. (Hold)
    Action to take for postings from non-members for which no explicit action is defined. (Hold)


#### 3. Auto-responder settings

    Should Mailman send an auto-response to mailing list posters? (Yes)
    Auto-response text to send to mailing list posters: "Sorry, only the site administrator can post to this list."
    Number of days between auto-responses: (0)


#### 4. Membership Management >> Membership List

    Set everyone's moderation bit, including those members not currently visible (On)


You could turn off the moderation bit for moderators email addresses, 
but this is not very secure because email addresses can be easily forged.



---
[lunarpages]: <http://wiki.lunarpages.com/MailMan_Announce_Only_Mailing_List>
