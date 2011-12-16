# Fuel Continuous Testing

## Introduction
By leveraging the ruby gem watchr, oil test, and growl or notify-send depending on if you are on linux or OS X; Fuel Continuous Testing gives you continuous testing with UI feedback.

## Dependencies
*	[Watchr](https://github.com/mynyml/watchr "Watchr")
*	[Fuel](http://fuelphp.com/ "Fuel")

## Installation
Place *config/* and *testing* in your project's DOCROOT. Execute *./testing* from your Project's DOCROOT to run. Modify a php file in your project and you should have all of your Tests in @group app run.  

## Credits
Fuel-Continuous-Testing was heavily inspired by [Autotesting with watchr, growl and PHPUnit](http://criticallog.thornet.net/2011/03/08/autotesting-with-watchr-growl-and-phpunit/ "Autotesting with watchr, growl and PHPUnit")