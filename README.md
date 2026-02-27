# devemtiazecom

Q1: How is horizontal swipe implemented?
Ans: Horizontal swipe is handled by TabBarView, which internally uses PageView. It listens for horizontal drag gestures and is synchronized with TabBar via a shared TabController.


Q2: Who owns vertical scroll and why?
Ans: The inner CustomScrollView owns the vertical scroll, but NestedScrollView coordinates it with the outer slivers using SliverOverlapAbsorber and SliverOverlapInjector. This allows the header to collapse seamlessly while maintaining independent scroll positions per tab.


Q3: Trade-offs or limitation?
Ans: Although it feels like a single scroll, it’s Not Truly One Scrollable. NestedScrollView internally manages two coordinated ScrollPositions. There are two ScrollPositions (i)Outer (header) (ii)Inner (CustomScrollView per tab). They are just coordinated.