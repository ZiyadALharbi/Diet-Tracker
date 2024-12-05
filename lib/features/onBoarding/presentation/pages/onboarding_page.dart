import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Welcome!",
      "subtitle":
          "Congratulations on taking the first step toward a healthier you!"
    },
    {
      "title": "Effortless Tracking",
      "subtitle": "Easily log your meals, snacks and water intake"
    },
    {
      "title": "Goal Setting",
      "subtitle": "Set realistic goals and watch your progress unfold"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Builder(builder: (context) {
                          return Text(
                            _onboardingData[index]["title"]!,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                            textAlign: TextAlign.center,
                          );
                        }),
                        const SizedBox(height: 16),
                        Builder(builder: (context) {
                          return Text(
                            _onboardingData[index]["subtitle"]!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text("skip") // have to deal with the color
                      ),
                  Row(
                    children: List.generate(
                      _onboardingData.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Colors.blue
                              : Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  FloatingActionButton(
                      onPressed: () {
                        if (_currentPage < _onboardingData.length - 1) {
                          _pageController.nextPage(
                              duration: const Duration(microseconds: 300),
                              curve: Curves.easeInOut);
                        }
                      },
                      shape: const CircleBorder(),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: MediaQuery.of(context).size.width * 0.06,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
