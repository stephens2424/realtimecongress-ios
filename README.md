# Real Time Congress for iOS

Built by the Sunlight Foundation. Available on the [App Store](http://itunes.apple.com/us/app/real-time-congress/id346005313?mt=8).

## Present vs. Future

The app currently in the App Store is built with HTML and runs on top of PhoneGap. The code is available in a [separate repository](https://github.com/sunlightlabs/real_time_congress-iphone_html). That project is no longer active.

The project is transitioning to a native iOS app. It needs to preserve all current features of Real Time Congress, incorporate features currently present in [Congress for Android](http://sunlightfoundation.com/projects/congress-for-android/) and [Stream Congress](http://streamcongress.com), and hopefully add in more new features on top of all of that. It will use Sunlight's [Congress API](http://services.sunlightlabs.com/docs/Sunlight_Congress_API/) and [Real Time Congress API](http://services.sunlightlabs.com/docs/Real_Time_Congress_API/) for Congressional data.

### Phase 1

First, we need to create and publish the iOS app while replacing the features of the PhoneGap app:

* A live stream of floor updates
* A daily schedule of committee hearings
* Links to legislative documents and whip notices

We will not be replacing the "news" feature.

### Phase 2

Once we reach feature parity with the PhoneGap app, new features can be tackled. These are largely inspired by Congress for Android and Stream Congress.

* Members of Congress
  * Search by name, state, zip code, amd device geolocation
  * View contact information, voting record, and committee membership
  * View social media and news updates
* Committees
  * Browse and search by name
  * View membership and schedule of hearings
* Legislation
  * Browse and search for bills
  * View roll call vote record on bills
* Marking entities as a favorite

### Phase 3

Time to really harness the features of iOS and think outside the box:

* Notifications
* Live video streaming
* iPad interface
* ???

## Build Instructions

### Cloning

When you clone this repository, you also need to clone the submodule with the following:

    git submodule update

### API Key

You need to find the file APIKeys.example.plist. It is within the Xcode project file (secondary click it, and choose Show Package Contents). *Duplicate* the plist file and remove the .example portion of the filename. Open the file and replace YOUR API KEY HERE with your API Key. You can register for an API Key here: [http://services.sunlightlabs.com/accounts/register/](http://services.sunlightlabs.com/accounts/register/).

## Google Summer of Code

GSoC students applying for this project should expect to work on Phases 2 and 3. Phase 1 should be mostly complete by May 23, the beginning of Google Summer of Code. A strong applicant will demonstrate real-world experience with iOS plus an understanding of the mission and activities of Sunlight Labs. More ideas are encouraged for Phase 3. Applicants should be creative, self-directed, and entrepreneurial. Strong communication skills are a must.

## Questions

Email luigi (at) sunlightfoundation.com or find LuigiMontanez on Freenode in the #sunlightlabs channel.