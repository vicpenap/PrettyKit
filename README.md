# PrettyKit

`PrettyKit` is a small set of new widgets and UIKit subclasses that 
gives you a deeper UIKit customization. You will be able to change 
their background color, add gradients, shadows, etc.

At the time of writing these docs, there are subclasses for 
`UITableViewCell`, `UINavigationBar` and `UITabBar`, and several custom
cells.

Here are some examples of what you can achieve:

![](https://github.com/vicpenap/PrettyKit/raw/master/Screenshots/grouped_table.png)

![](https://github.com/vicpenap/PrettyKit/raw/master/Screenshots/plain_table.png)

## Documentation

Full documentation can be found here: http://vicpenap.github.com/PrettyKit

## Using it

Using this framework is really easy.

First:

- Copy all files under the `PrettyKit` folder. 
- `#import "PrettyKit.h"` where you need it.

Then, just change all your references to UI classes to Pretty classes, 
and you're done.

You'll find further information on how to use the classes in the docs.

## Customization

All Pretty objects' properties have default values, but you can freely
change them.

#### Pretty Cell

##### Grouped tables

You can change the cell's appearance as follows:

- cell's shadow (border will be disabled when the shadow is enabled).
- cell's background color or gradient.
- cell's border color (border will be disabled when the shadow is enabled).
- cell's corner radius.
- cell's separator.
- cell's selection gradient.

##### Plain tables

You can change the cell's appearance as follows:

- cell's background color or gradient.
- cell's separator.
- cell's selection gradient.

#### Pretty Navigation Bar

 You can change the navigation bar appearance as follows:
 
 - shadow opacity
 - gradient start color
 - gradient end color
 - top line volor
 - bottom line color


#### Pretty Tab Bar

 You can change the tab bar appearance as follows:
 
 - gradient start color
 - gradient end color
 - separator line volor

## Performance

Everything is drawn using Core Graphics, so you can expect a nice 
performance. Particular attention has been paid to non opaque areas,
trying to reduce them as much as possible.

![](https://github.com/vicpenap/PrettyKit/raw/master/Screenshots/blended_layers.png)

## Current status

This framework is currently under active development. It is compatible 
with iOS 4.0 or higher.
 
## Contribution

Please, please contribute with this project! Fork it, improve it and make 
me a pull request.

## Changelog

- 2012/04/12 (v0.1.0): Initial release
