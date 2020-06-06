<?php

$IS_DEBUG = getenv('IS_DEBUG');
$DEBUG_SERVER = getenv('SERVER_HOST');

# Visual Editor의 API URL로도 사용하기 때문에 매우 중요!
## The protocol and server name to use in fully-qualified URLs
$wgServer = getenv('SERVER_HOST');
$wgCanonicalServer = getenv('CANONICAL_SERVER');

# Trust an X-Forwarded-For (XFF) header specifying a private IP in requests
# from a trusted forwarding proxy
$wgSquidServersNoPurge = [ '10.0.0.0/8' ];

# Database settings
$wgDBserver = getenv('DATABASE_HOSTNAME');
$wgDBname = getenv('DATABASE_NAME');
$wgDBuser = getenv('DATABASE_USERNAME');
$wgDBpassword = getenv('DATABASE_PASSWORD');

# Visual Editor
# WHY: Elastic Beanstalk Docker 설정에서 Network Mode 설정이 안되고 Links 설정으로 HOSTNAME을 연결해야 함
# 여기서 순환 참조가 일어나 FAILED, PARSOID의 주소를 강제로 주입하는 방법으로 해결 on Elastic Beanstalk Application Environment
$wgVirtualRestConfig['modules']['parsoid'] = array(
    'url' => getenv('PARSOID_HOST'),
    'domain' => 'mediawiki',
);

# Email & SMTP
$wgEmergencyContact = getenv('EMERGE_CONTACT_EMAIL_ADDR');
$wgPasswordSender   = getenv('PASSWORD_SENDER_CONTACT_EMAIL_ADDR');

$wgSMTP = [
    'host'      => getenv('SMTP_HOST'),
    'IDHost'    => getenv('SMTP_HOST'),
    'port'      => 25,
    'auth'      => false,
    'username'  => getenv('SMTP_USERNAME'),
    'password'  => getenv('SMTP_PASSWORD'),
];

# Email bounce handler, for Debug 127.0.0.1
$wgBounceHandlerInternalIPs = [ '0.0.0.0/0' ];

# Site secret key
$wgSecretKey = getenv('MW_SECRET_KEY');
# Site upgrade key. Must be set to a string (default provided) to turn on the
# web installer while LocalSettings.php is in place
$wgUpgradeKey = getenv('MW_UPGRADE_KEY');

# AWS
// Configure AWS credentials.
// THIS IS NOT NEEDED if your EC2 instance has an IAM instance profile.
$wgAWSCredentials = [
	'key' => getenv('AWS_S3_ACCESS_KEY'),
	'secret' => getenv('AWS_S3_SECRET_KEY'),
	'token' => false
];
$wgAWSRegion = getenv('AWS_S3_REGION_NAME');
$wgAWSBucketName = getenv('AWS_S3_BUCKET_NAME');

# Google Maps
$egMapsGMaps3ApiKey = getenv('GOOGLE_MAPS_API_KEY');

# Google Analytics
# TODO: GTag.js Extension 개발로 따로 빼기
$wgHooks['BeforePageDisplay'][]  = 'efGoogleAnalyticsInsertHook';

function efGoogleAnalyticsInsertHook( OutputPage &$out, Skin &$skin ) {
	$googleAnalyticsTrackingID = getenv('GOOGLE_ANALYTICS_TRACKING_ID');
	$code = <<<EOF
<script async src="https://www.googletagmanager.com/gtag/js?id=$googleAnalyticsTrackingID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', '$googleAnalyticsTrackingID');
</script>
EOF;

	$out->addHeadItem( 'gtag-insert', $code );
	return true;
}
