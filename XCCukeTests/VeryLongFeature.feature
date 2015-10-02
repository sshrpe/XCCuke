@MOBIP-5972 @manual  @categories

Feature: Categories Menu Offline behaviour
As a user
I want to use the category menu when offline
So that I can still enjoy the categories section without a connection

Scenario: Request highlights feed but offline
Given I go to the Categories view
And I will see the category highlight stream
When the device goes offline
And I select a different category
Then I will see the offline error message in the place of the grid

Scenario: Offline with recently viewed data
Given I go to the Categories view
And the device goes offline
When I select a different category that has recently been viewed
Then I will see the different category highlight stream

Scenario: Device regains connection, not currently viewing data
Given I am offline
And I am viewing the offline error message in the place of the grid
When the device regains connection
Then the selected category highlights feed will be reloaded

Scenario: Device regains connection, currently viewing data
Given I am currently viewing categories highlights feed
And the device is offline
When the device regains connection
Then the selected category highlights feed will not be reloaded

Scenario: Device is offline, 'go to downloads selected'
Given I can see the no connection message
When I select 'Go to Downloads'
Then I will see the Downloads view

Scenario: Request menu feed but offline
Given I am on the home page
And the device goes offline
When I select the Categories option
Then I will see the menu no connection message in the place of the grid

@automated
Scenario: Selecting any category with 6 or more category highlights
Given I go to the Categories view
Then I will see a list of category highlights displayed in a grid layout

@simulator @tablet @automated  @act1
Scenario Outline: Changing orientation re-formats the grid to the correct layout
Given I go to the Categories view
And I am in <starting orientation> view
When I re-orientate the device to <finishing orientation> view
Then I will see the grid layout for <layout view> view
Examples:
|starting orientation |finishing orientation  |layout view|
|portrait             |landscape              |landscape  |
|landscape 	          |portrait 	          |portrait   |

@manual
Scenario Outline: Scrolling behaviour based upon device orientation
Given I go to the Categories view
And I am in <orientation> view
When I scroll <scroll direction>
Then more cells will <appear>
Examples:
|orientation  |scroll direction |appear|
|portrait 	|vertically 	  |appear|
|landscape 	|horizontally 	  |appear|
|portrait 	|horizontally 	  |not appear|
|landscape 	|vertically 	  |not appear|

@act1
Scenario: Category cells will contain programme information
Then the programme cells will be populated with the following information
| Channel attribution |
| Programme title     |
| Episode title       |
| Episode image       |

Scenario: If the iBL feed is missing a field then display a blank field for Categories
And the highlights feed has an episode attribute missing
Then a blank field for the missing attribute will be displayed

Scenario: Single tap of the cell goes to the PiP
When I tap an episode cell
Then I will see the PIP for the episode

@android @tablet @wip
Scenario: Editorial Collection Metadata for Categories
Given the device is in landscape
When there is a editorial collection available
Then I will see the following collection items:
| category title       |
| number of programmes |

@android @tablet
Scenario: Editorial collection list cell
Given I have navigated to an editorial collection list cell
Then I will see the following collection items:
| category title       |
| number of programmes |
| list of programmes   |

Scenario: Offline, no cached highlights stream data
Given I am on a cached channels page
And I am offline
And I have a cached menu
When I select a channel that has not been cached
Then the no connection message "Highlights no connection" appears in place of the grid

Scenario: Offline, has cached data
Given I am on a cached channels page
And I am offline
And I have a cached menu
When I select a channel that has been cached
Then the grid is populated with cached data

Scenario: Come online, no cached data
Given I am on a cached channels page
And I am offline
And I have a cached menu
And I select a channel that has not been cached
When I regain connection
Then the selected channel highlights feed will be reloaded

Scenario: Come online, cached data
Given I am on a cached channels page
And I am offline
When I regain connection
Then the selected channel highlights feed will not be reloaded

Scenario: Offline, go to Downloads selected for Channels highlights
Given I have received the no connection message
When I tap "Go to Downloads"
Then the Downloads section is launched

@manual
Scenario: User will receive Bill Shock message on first ever play
Given I'm in the Channels view
And the channel is on air
And I am a 3G user
When I tap on the live episode image
Then I will see the Bill Shock message

@manual
Scenario: User accepts bill shock message will see live playback screen
Given I'm in the Channels view
And the channel is on air
And I am a 3G user
When I tap on the live episode image
And I accept the Bill Shock message
Then I will see live playback

@manual
Scenario: User declines the bill shock message will see live playback screen
Given I'm in the Channels view
And the channel is on air
And I am a 3G user
When I tap on the live episode image
And I declines the Bill Shock message
Then I will not see live playback

@ios @automated
Scenario: Tapping on episode image goes straight to live playback
Given I'm in the Channels view
And the channel is on air
When I touch the live episode image
Then I will see live playback

@manual
Scenario: 3g User - Tapping on episode image goes straight to live playback
Given I'm in the Channels view
And the channel is on air
And I am a 3G user
And I have previously accepted the Bill Shock message
When I tap on the live episode image
Then I will see live playback

@landscape @manual @android
Scenario: Tapping on a collection cell on Tablet shows the items contained within the highlights feed - android
Given the device is in landscape
When there is a series collection available
And I tap a collection cell
Then I see the list of collection items from the highlights feed, as part of the collection cell

@manual @android
Scenario: Collection items are shown in the collection cell - android
When there is a series collection available
Then I see collections items as part of the collection cell

@reset_channels_hk_ios @manual @android
Scenario: Editorial Collection Metadata for Channels  - android
When there is an editorial collection available
Then I will see the following metadata:
| Collection title     |
| Number of programmes |

@manual @android
Scenario: Series Collection Metadata for Tablet - android
When there is a series collection available
Then I will see the following metadata:
| Programme title |
| Episode title   |

@landscape @ios @automated
Scenario: Tapping on a collection cell on Tablet shows the items contained within the highlights feed - ios
Given the device is in landscape
When there is a series collection available
And I tap a collection cell
Then I see the list of collection items from the highlights feed, as part of the collection cell

@ios @automated
Scenario: Collection items are shown in the collection cell - ios
When there is a series collection available
Then I see collections items as part of the collection cell

@reset_channels_hk_ios @ios @automated
Scenario: Editorial Collection Metadata for Channels  - ios
When there is an editorial collection available
Then I will see the following metadata:
| Collection title     |
| Number of programmes |

@ios @automated
Scenario: Series Collection Metadata for Tablet - ios
When there is a series collection available
Then I will see the following metadata:
| Programme title |
| Episode title   |


@hive-1-ios @live_ios  @ios
Scenario: TV page, channels button is replaced with TV guide
Given I'm on the home page
Then I should see the TV guide button

@hive-1-ios @live_ios @act1  @ios
Scenario: Selecting this link takes user to existing TV Guide view
Given I'm on the home page
When I tap TV Guide
Then I will see the TV Guide view


@MOBIP-7706 @automated @act1 @android
Scenario: Channel with no schedule is not displayed in TV Guide list - android
Given I am on the TV Schedule page
When there is a channel available in the feed without schedule
Then I will not see the channel which has no schedule in the TV Guide list

@MOBIP-7706 @automated @act1 @ios
Scenario: Channel with no schedule is not displayed in TV Guide list - ios
Given I am on the TV Schedule page
When there is a channel available in the feed without schedule
Then I will not see the channel which has no schedule in the TV Guide list

@MOBIP-7750 @automated @act1
Scenario: TV Guide loads properly when channels have no schedule element
Given the channels do not have schedule element
When I am on the TV Schedule page
Then I will see the TV Guide view

@manual
Scenario: When one episode is favourited, then all episodes in the same series are also favourited
Given I'm on a PIP for a programme
And the TLEO can be favourited
When I tap the favourites button
Then all episodes in the series are favourited

@automated
Scenario: The favourited programmes appear in the Favourites screen
Given I'm on the PIP for a Most popular programme
And the TLEO is available
When I select the favourites button
Then the programme will be added to my favorites list

@automated
Scenario: PIP displays the programme is favourited
Given I have favourited a programme
Then the favourites star will be selected

@automated @android
Scenario: Confirmation message appears upon a Favourite being added
Given I'm on a PIP for a programme
When I select the favourites button
Then the favourites confirmation message will appear

@manual
Scenario Outline: [Screen Reader] An episode can be added using a Screen Reader
Given I enable the Screen Reader
And I navigate to the PiP
When I <action> the favourites button
Then I will hear appropriate feedback
Examples:
| action     |
| focus on   |
| activate   |
| deactivate |

@automated @android @act1
Scenario: Unfavouriting from the PiP no longer displays the TLEO in the Favourites page - Android
Given I'm on the PIP for a favourited programme
When I select the favourites button
Then the programme will be removed from my favorites list

@automated @ios @act1
Scenario: Unfavouriting from the PiP no longer displays the TLEO in the Favourites page - iOS
Given I'm on the PIP for a favourited programme
When I select the favourites button to un-favourite the programme
Then the programme will be removed from my favorites list

@iOS @wip
Scenario: Unfavouriting from the Favourites page no longer displays the TLEO in the Favourites page
Given needs steps

@automated
Scenario: PIP displays the programme is not favourited
Given I have removed a favourite programme
Then the favourites star will not be selected

@automated @android
Scenario: Confirmation message appears upon a Favourite being removed
Given I'm on the PIP for a favourited programme
When I select the favourites button
Then the remove favourites confirmation message will appear

@portrait @automated
Scenario: Most popular cover image for phone and tablet portrait
Given the Most popular collection is on screen
Then the most popular collection composite image will be displayed

@tablet @landscape @automated
Scenario:  Tapping on the Most popular cover image will  display the Most popular items - tablet landscape
Given the Most popular collection is on screen
And I am in landscape view
When I tap the Most popular cover image
Then I will see the list of Most popular items slide into view over the cover image

@phone @automated @act1
Scenario:  Tapping on the Most popular cover image will display the Most popular item - phone
Given the Most popular collection is on screen
When I tap the Most popular cover image
Then I will see the list of Most popular items

@wip
Scenario: Most Popular cells displays their numeric position
Given the Most popular collection is on screen
When I tap the Most popular cover image
Then I would see the episode cells numbered as per their position

@tablet @landscape @automated @android
Scenario: Most Popular Collection is Scrollable
Given I am on the Home page
And I am in landscape view
And the Most popular collection is on screen
When I tap the Most popular cover image
And the most popular collection is scrolled down
Then I will see more items
