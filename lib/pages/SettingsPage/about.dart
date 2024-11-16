import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:go_router/go_router.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            height: deviceHeight,
            width: deviceWidth,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffead4f9),
                  Color(0xfff7f1d1),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                context.pop();
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: AppColors.sliderColor,
                                size: 25,
                              ),
                            ),
                            const SizedBox(width: 20),
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [
                                  AppColors.textColorGrey,
                                  AppColors.textColorSettings,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ).createShader(
                                Rect.fromLTWH(
                                    0.0, 0.0, bounds.width, bounds.height),
                              ),
                              child: Text(
                                "About",
                                style: theme.textTheme.headlineMedium!.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColorWhite),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          ' PRIVACY POLICY (Last Updated: November 14, 2024)',
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: AppColors.textColorblack,
                              fontWeight: FontWeight.w600),
                        ),
                        Text('''
              
This Privacy Policy explains how Fabletronic Technologies Private Limited (“Pixie”,"we", "us", or "our") collects, uses, and shares information about you when you use the Pixie website or app ("Service") or any related services. By using the Service, you agree to the collection, use, and disclosure of your information as described in this Privacy Policy.
              
Information We Collect
              
We collect the following types of information when you use our Service:
              
Account Information: When you register for an account, participate in interactive features, fill out a form or a survey, communicate with our customer support, or otherwise communicate with us. The information you may provide includes your name, email address, phone number, password, and/or other information you choose to provide.
Usage Information: We collect information about how you use our Service, including your audio and location.
              
The above facilitates our ability to send you transactional or relationship communications, such as receipts, account notifications, customer service responses, and other administrative messages. It assists us in identifying, preventing, and rectifying technical and security issues;
              
We use it to personalize your experience, tailor content according to your interests, and shape the advertisements you encounter on other platforms in line with your preferences, interests, and browsing behavior;
              
We comply with the law by using it to process transactional records for tax filings and other compliance activities. We enforce our Terms of Use and fulfill our legal obligations using this information;
              
Data Retention
              
We retain your information for as long as necessary to provide the Service and fulfill the purposes outlined in this Privacy Policy, unless a longer retention period is required or permitted by law.
              
Data Security
We take reasonable measures, including administrative, technical, and physical safeguards, to protect your information from loss, theft, misuse, unauthorized access, disclosure, alteration, and destruction. We utilize industry-standard security measures. However, no method of transmission over the Internet, or method of electronic storage, is completely secure, and while we strive to protect your personal information, we cannot guarantee its absolute security.
              
Children's Privacy
              
The App is intended for users who are at least 18 years old. As part of the App's functionality, you may be asked to create a profile that includes a first name, age, and other information of children. This information is used to generate customized stories for children. This information is kept confidential and is not shared with third parties, except as described in our Privacy Policy.
              
Third Party Services
              
Our Service uses third-party service providers to enable certain features and improve the functionality of our service. For the Service, these third-party services include OpenAI and Meta, and ElevenLabs which facilitate the AI-driven story generation in our Service. When you create a story using our Service, we send information that you input into the story generator to these services, which process this data and return AI-generated text to be incorporated into your story. Please note that we do not share any personally identifiable information, such as your name or email address, with these service providers when creating these stories.
              
For our Service, these third-party service providers have their own privacy policies addressing how they use such information. Please note that we do not control and are not responsible for the privacy practices of these third-party services. We recommend you review their respective privacy policies to understand how they collect, use, and share your data.
              
Your Rights and Choices
In accordance with applicable law, you may have certain rights regarding the personal information we maintain about you. These may include the rights to access, rectification, deletion, restrict processing, data portability, and withdrawal of consent. Below we describe the processes for you to exercise these rights. 
              
Access: You have the right to request access to the personal information that we hold about you. This includes a right to access the personal information that constitutes part of your account and other basic information.
Rectification: If you believe that any of the personal information that we hold about you is inaccurate or incomplete, you have a right to request that we correct or complete such personal information.
Deletion: You have the right to request deletion of personal information that we hold about you.
Restrict Processing: You have the right to request that we restrict processing of your personal information where you believe such data to be inaccurate; our processing is unlawful; or that we no longer need to process such data for a particular purpose unless we are not able to delete the data due to a legal or other obligation.
Withdrawal of Consent: If you have consented to our processing of your personal information, you have the right to withdraw your consent at any time, free of charge. This includes cases where you wish to opt out of marketing messages that you receive from us.
              
To exercise these rights, please contact us at shivbansal@mypixie.in We will respond to your request consistent with applicable laws. To protect your privacy and security, we may require you to verify your identity.
              
Information for California Residents
              
This section provides additional disclosures required by the California Consumer Privacy Act (or "CCPA"). Please see below for a list of the personal information we have collected about California consumers in the last 12 months, along with our business and commercial purposes and categories of third parties with whom this information may be shared. For more details about the personal information we collect, including the categories of sources, please see the "Collection of Information" section above.
              
Categories of personal information we collect
Identifiers, such as your name, phone number, email address, and unique identifiers (like IP address) tied to your browser or device. Characteristics of protected classifications under state or federal law, such as gender and age.Internet or other electronic network activity, such as browsing behavior and information about your usage and interactions with our Service. Other personal information you provide, including opinions, preferences, and personal information contained in product reviews, surveys, or communications. Inferences drawn from the above, such as product interests, and usage insights.
              
Business or commercial purposes for which we may use your information
              
Performing or providing our services, such as to maintain accounts, provide customer service, process orders and transactions, and verify customer information.
              
Improving and maintaining our Service, such as by improving our services and developing new products and services. Debugging, such as to identify and repair errors and other functionality issues.
              
Communicate with you about marketing and other relationship or transactional messages.
              
Analyze usage, such as by monitoring trends and activities in connection with use of our Service.
              
Personalize your online experience, such as by tailoring the content you see on our Service based on your preferences, interests, and browsing behavior. 
              
Legal reasons, such as to help detect and protect against security incidents, or other malicious, deceptive, fraudulent, or illegal activity.
              
Parties with whom information may be shared
              
Companies that provide services to us, such as those that assist us with customer support, subscription and order fulfillment, data analytics, fraud prevention, cloud storage, and payment processing.
              
Third parties with whom you consent to sharing your information, such as with social media services or academic researchers.
              
Our advertisers and marketing partners, such as partners that help determine the popularity of content, deliver advertising and content targeted to your interests, and assist in better understanding your online activity.
              
Government entities or other third parties for legal reasons, such as to comply with law or for other legal reasons as described in our Sharing section. Subject to certain limitations and exceptions, the CCPA provides California consumers the right to request to know more details about the categories and specific pieces of personal information, to delete their personal information, to opt out of any "sales" that may be occurring, and to not be discriminated against for exercising these rights.
              
We do not "sell" the personal information we collect (and will not sell it in the future without providing a right to opt out). We do allow our advertising partners to collect certain device identifiers and electronic network activity via our Services to show ads that are targeted to your interests on other platforms.
              
California consumers may make a rights request by emailing us at shivbansal@mypixie.in. We will verify your request by asking you to provide information that matches information we have on file about you. Consumers can also designate an authorized agent to exercise these rights on their behalf. Authorized agents should submit requests through the same channels, but we will require proof that the person is authorized to act on your behalf and may also still ask you to verify your identity with us directly.
              
Information for European Union Users
If you are a user from the European Union, you have certain rights and protections under the General Data Protection Regulation (GDPR).
              
Rights of EU Users
              
Under the GDPR, you have the following rights:
              
Right to Access: You have the right to request access to your personal data that we process.
Right to Rectification: If the personal data we hold about you is inaccurate or incomplete, you have the right to have this information rectified or, taking into account the purposes of the processing, completed.
Right to Erasure (‘Right to be Forgotten’): You have the right to request the erasure of your personal data.
Right to Restrict Processing: You have the right to request that we restrict the processing of your personal data.
Right to Data Portability: You have the right to receive your personal data in a structured, commonly used, machine-readable format and have the right to transmit those data to another controller without hindrance, where technically feasible.
Right to Object: You have the right to object to the processing of your personal data for reasons related to your particular situation, at any time. The right to object also specifically applies to data processing for direct marketing purposes.
Right not to be subject to Automated Decision-making: You have the right not to be subject to a decision based solely on automated processing, including profiling, which produces legal effects concerning you or similarly significantly affects you.
If you wish to exercise any of these rights, please contact us at shivbansal@mypixie.in. We may ask you to verify your identity for security purposes.
              
Data Transfers
              
We wish to remind you that your personal data may be transferred to, stored, and processed in the United States where our servers are located. Some of these countries may not have the same data protection laws as the European Union. We ensure that such data transfers comply with applicable laws, including the GDPR, by relying on legal data transfer mechanisms such as Standard Contractual Clauses.
              
Data Protection Officer
              
 If you have any questions or concerns about our use of your personal data, you can contact our Data Protection Officer at shivbansal@mypixie.in. Please note that you also have the right to lodge a complaint with your local data protection authority or the appropriate authority under the applicable law.
              
Cookies, Analytics, and Similar Technologies
We use cookies, analytics, and similar technologies to personalize and enhance your experience on our Website and App. Cookies, web beacons, device identifiers and other technologies collect information about your use of the Services and other websites and online services, including your IP address, device identifiers, web browser, mobile network information, pages viewed, time spent on pages or in apps, links clicked, and conversion information. These technologies allow us to remember your preferences, understand the performance of our Website, provide social media features, and customize content and advertisements relevant to your interests.
              
 You have the right to decide whether to accept or reject cookies. Most browsers automatically accept cookies, but you can modify your browser settings to decline cookies if you prefer. If you choose to decline cookies, some parts of our Website may not work as intended or may not work at all.
              
Please note that if you choose to remove or reject cookies, this could affect the availability and functionality of our Website. If you have any questions about our use of cookies or other technologies, please email us at shivbansal@mypixie.in.
              
Changes to This Privacy Policy
We may update this Privacy Policy from time to time. If we make changes, we will notify you by revising the date at the top of the policy and, in some cases, we may provide you with additional notice (such as adding a statement to our website homepage or sending you a notification through the App or by email). Your continued use of our Service after such changes become effective constitutes your acceptance of the new Privacy Policy.
              
Contact Us 
If you have any questions about this Privacy Policy, please contact us at: shivbansal@mypixie.in .
                            
              '''),
                      ]),
                ),
              ),
            )));
  }
}
