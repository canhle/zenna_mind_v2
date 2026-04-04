class BrowseMeditationItem {
  const BrowseMeditationItem({
    required this.title,
    required this.duration,
    required this.author,
    required this.badge,
    this.imageAsset,
  });

  final String title;
  final String duration;
  final String author;
  final String badge;
  final String? imageAsset;
}

class BrowseSection {
  const BrowseSection({
    required this.title,
    required this.items,
  });

  final String title;
  final List<BrowseMeditationItem> items;
}

// ── Trending ─────────────────────────────────────────────────────────────

const mockTrendingItems = [
  BrowseMeditationItem(
    title: 'Buổi sáng bình yên',
    duration: '15 phút',
    author: 'Minh Anh',
    badge: 'PHỔ BIẾN NHẤT',
  ),
  BrowseMeditationItem(
    title: 'Kết nối thiên nhiên',
    duration: '20 phút',
    author: 'Tuấn Kiệt',
    badge: 'MỚI PHÁT HÀNH',
  ),
];

// ── Topic sections (tab "Chủ đề") ────────────────────────────────────────

const mockTopicSections = [
  BrowseSection(
    title: 'Tiếng mưa & bão',
    items: [
      BrowseMeditationItem(
        title: 'Mưa nhẹ nhàng',
        duration: '15 phút',
        author: 'Thiên Nhiên',
        badge: 'PHỔ BIẾN',
      ),
      BrowseMeditationItem(
        title: 'Bão đêm xa xôi',
        duration: '30 phút',
        author: 'White Noise',
        badge: 'MỚI',
      ),
      BrowseMeditationItem(
        title: 'Rừng nhiệt đới',
        duration: '25 phút',
        author: 'Sâu Lắng',
        badge: 'GỢI Ý',
      ),
    ],
  ),
  BrowseSection(
    title: 'Nhạc thiền định',
    items: [
      BrowseMeditationItem(
        title: 'Chuông xoay Tây Tạng',
        duration: '20 phút',
        author: 'Zen Master',
        badge: 'PHỔ BIẾN',
      ),
      BrowseMeditationItem(
        title: 'Sáo trúc dịu dàng',
        duration: '15 phút',
        author: 'Hòa Âm',
        badge: 'MỚI',
      ),
      BrowseMeditationItem(
        title: 'Âm thanh vũ trụ',
        duration: '45 phút',
        author: 'Deep Space',
        badge: 'GỢI Ý',
      ),
    ],
  ),
];

// ── Mood sections (tab "Cảm xúc") ────────────────────────────────────────

const mockMoodSections = [
  BrowseSection(
    title: 'Bình yên',
    items: [
      BrowseMeditationItem(
        title: 'Hơi thở nhẹ nhàng',
        duration: '10 phút',
        author: 'Minh Anh',
        badge: 'PHỔ BIẾN',
      ),
      BrowseMeditationItem(
        title: 'Mặt hồ tĩnh lặng',
        duration: '20 phút',
        author: 'Thiên Nhiên',
        badge: 'GỢI Ý',
      ),
      BrowseMeditationItem(
        title: 'Hoàng hôn trên biển',
        duration: '15 phút',
        author: 'Sâu Lắng',
        badge: 'MỚI',
      ),
    ],
  ),
  BrowseSection(
    title: 'Tập trung',
    items: [
      BrowseMeditationItem(
        title: 'Dòng chảy công việc',
        duration: '25 phút',
        author: 'Focus Lab',
        badge: 'PHỔ BIẾN',
      ),
      BrowseMeditationItem(
        title: 'Năng lượng buổi sáng',
        duration: '10 phút',
        author: 'Tuấn Kiệt',
        badge: 'MỚI',
      ),
      BrowseMeditationItem(
        title: 'Tĩnh tâm sáng tạo',
        duration: '30 phút',
        author: 'Zen Master',
        badge: 'GỢI Ý',
      ),
    ],
  ),
];
