<?php

$IS_DEBUG = true;
$DEBUG_SERVER = 'http://wiki.local';

# Visual Editor의 API URL로도 사용하기 때문에 매우 중요!
## The protocol and server name to use in fully-qualified URLs
$wgServer = "http://wiki.hanyang.ac.kr";

# Trust an X-Forwarded-For (XFF) header specifying a private IP in requests
# from a trusted forwarding proxy
$wgSquidServersNoPurge = [ '10.0.0.0/8' ];

# Database settings
$wgDBserver = 'YOUR_DATABASE_HOSTNAME';
$wgDBname = "YOUR_DATABASE_NAME";
$wgDBuser = 'YOUR_DATABASE_USERNAME';
$wgDBpassword = 'YOUR_DATABASE_PASSWORD';

# Visual Editor
$wgVirtualRestConfig['modules']['parsoid'] = array(
    'url' => 'PARSOID_HOST',
    'domain' => 'mediawiki',
);

# Email & SMTP
$wgEmergencyContact = "YOUR_EMERGE_CONTACT_EMAIL_ADDR";
$wgPasswordSender   = "YOUR_PASSWORD_SENDER_CONTACT_ADDR";

$wgSMTP = [
    'host'      => 'YOUR_SMTP_HOST',
    'IDHost'    => 'YOUR_SMTP_HOST',
    'port'      => 25,
    'auth'      => false,
    'username'  => 'YOUR_SMTP_USERNAME',
    'password'  => 'YOUR_SMTP_PASSWORD',
];

# Email bounce handler, for Debug 127.0.0.1
$wgBounceHandlerInternalIPs = [ '0.0.0.0/0' ];

# Google Analytics Tracking ID
$wgGoogleAnalyticsAccount = 'GOOGLE_ANALYTICS_ACCOUNT_ID';

# Site secret key
$wgSecretKey = 'SECRET_KEY';
# Site upgrade key. Must be set to a string (default provided) to turn on the
# web installer while LocalSettings.php is in place
$wgUpgradeKey = 'UPGRADE_KEY';

# AWS
// Configure AWS credentials.
// THIS IS NOT NEEDED if your EC2 instance has an IAM instance profile.
$wgAWSCredentials = [
	'key' => 'YOUR_AWS_KEY',
	'secret' => 'YOUR_AWS_SECRET_KEY',
	'token' => false
];
$wgAWSRegion = 'ap-northeast-2';
$wgAWSBucketName = "YOUR_AWS_BUCKET_NAME";
