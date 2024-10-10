import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService {
  Future<String> createStoryShareLink(String storyId, String title) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix:
          'https://yourapp.page.link', // Your Firebase Dynamic Link domain
      link: Uri.parse('https://yourapp.com/story?id=$storyId'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.yourapp', // Your Android package name
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.example.yourapp', // Your iOS bundle ID
        appStoreId: '123456789', // Your app’s App Store ID (if available)
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: title,
        description: 'Check out this story on our app!',
        imageUrl: Uri.parse('https://yourapp.com/your-logo.png'),
      ),
    );

    final ShortDynamicLink shortLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);

    return shortLink.shortUrl.toString();
  }
}
