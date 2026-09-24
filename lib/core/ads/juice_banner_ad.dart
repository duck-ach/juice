import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_unit_ids.dart';

/// 하단 탭바 바로 위에 고정으로 들어가는 배너 광고 스트립.
///
/// 화면 폭에 맞춘 adaptive 배너 크기를 써서 언어별 UI 크기와 무관하게 항상 고정
/// 높이를 유지하고, 로드 실패 시에는 [SizedBox.shrink]로 완전히 접혀 빈 여백이
/// 남지 않는다.
class JuiceBannerAd extends StatefulWidget {
  const JuiceBannerAd({super.key});

  @override
  State<JuiceBannerAd> createState() => _JuiceBannerAdState();
}

class _JuiceBannerAdState extends State<JuiceBannerAd> {
  BannerAd? _bannerAd;
  bool _requested = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_requested) {
      _requested = true;
      _loadAd();
    }
  }

  Future<void> _loadAd() async {
    final width = MediaQuery.sizeOf(context).width.truncate();
    final size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(width);
    if (size == null || !mounted) return;

    final ad = BannerAd(
      adUnitId: AdUnitIds.banner,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (loadedAd) {
          if (!mounted) {
            loadedAd.dispose();
            return;
          }
          setState(() => _bannerAd = loadedAd as BannerAd);
        },
        onAdFailedToLoad: (failedAd, error) => failedAd.dispose(),
      ),
    );
    await ad.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ad = _bannerAd;
    if (ad == null) return const SizedBox.shrink();
    // 배너 아래에 bottomNavigationBar가 있어 화면 하단 SafeArea는 그쪽에서 처리된다.
    return SizedBox(
      width: ad.size.width.toDouble(),
      height: ad.size.height.toDouble(),
      child: AdWidget(ad: ad),
    );
  }
}
