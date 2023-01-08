# Image_search For Earning design 
An image search app using Google's Custom Search Engine, caching.

## Getting Started
This currently only works on desktop for Windows and Mac as the file handling is simple; could be updated to support mobile, too, with a little effort. Not quite sure how to think about making it work on the web...

[Google Custom Search Engine project](https://stackoverflow.com/a/34062436).

With these files in place, you can run the app like this:

```shell
$ flutter clean
$ flutter pub get 
$ flutter run android 
$ flutter run iOS
```

And expect results like this:

<img src='readme/demo.gif' />

## Implementation Details
The search is implemented with a helper class.

The caching is implemented with another  helper class and then shared between the  helper and the CachingNetworkImage so that both CSE search results (limited to 100 free/day) and the image downloads are cached.

Selection is implemented with a RawMaterialButton, since it handles the clicking and the outlining.

## Room for improvement
Right now, the URL is checked for known image extensions to avoid attempting to show anything that isn't a known image type, but really the file should be downloaded and the MIME type checked.

Also, the file handling could easily be fixed to support mobile; PRs gratefully accepted!

Further, there is no cache clearing policy -- it just grows forever! This could certainly be improved.

Finally, I didn't implementing paging, which the CSE API supports. Instead I just show the first 10 results, which I consider good enough for demo purposes.
