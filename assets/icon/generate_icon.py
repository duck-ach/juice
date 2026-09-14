"""주스(Juice) 앱 아이콘 생성 스크립트.
대시보드의 실제 주스 게이지(원형 컵 + 웨이브 액체)를 그대로 아이콘 마크로 축약해,
앱을 열었을 때 보이는 첫 화면과 아이콘이 시각적으로 이어지도록 한다.

산출물:
- icon_full.png       : iOS/Android 레거시용 (불투명 배경 포함, 1024x1024)
- icon_foreground.png : Android 적응형 아이콘 전경(투명 배경, 세이프존 안쪽에 배치)
"""

import math

from PIL import Image, ImageDraw, ImageFilter

S = 4  # 슈퍼샘플링 배율(다운스케일 시 안티에일리어싱 효과)
SIZE = 1024 * S

FRESH_ORANGE = (255, 122, 0, 255)
CITRUS_YELLOW = (255, 184, 0, 255)
DEEP_ORANGE = (230, 90, 0, 255)
CREAM = (255, 251, 245, 255)


def radial_gradient_bg(size):
    """상단은 시트러스 옐로우, 하단은 프레시 오렌지로 번지는 배경."""
    img = Image.new("RGBA", (size, size), FRESH_ORANGE)
    top = CITRUS_YELLOW
    bottom = FRESH_ORANGE
    for y in range(size):
        t = y / size
        r = round(top[0] + (bottom[0] - top[0]) * t)
        g = round(top[1] + (bottom[1] - top[1]) * t)
        b = round(top[2] + (bottom[2] - top[2]) * t)
        ImageDraw.Draw(img).line([(0, y), (size, y)], fill=(r, g, b, 255))
    return img


def draw_wave_layer(size, baseline, amplitude, phase, color):
    """baseline 아래를 [color]로 채우는 사인 웨이브 레이어(사각 전체 크기)."""
    layer = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(layer)
    points = []
    step = max(1, size // 400)
    for x in range(0, size + step, step):
        y = baseline + math.sin((x / size) * 2 * math.pi + phase) * amplitude
        points.append((x, y))
    points.append((size, size))
    points.append((0, size))
    draw.polygon(points, fill=color)
    return layer


def draw_leaf(size, cx, top_y):
    """컵 위쪽에 살짝 걸치는 작은 잎사귀 + 꼭지(오렌지 과일 실루엣 힌트)."""
    layer = Image.new("RGBA", (size, size), (0, 0, 0, 0))

    stem_w, stem_h = size * 0.012, size * 0.05
    ImageDraw.Draw(layer).rounded_rectangle(
        (cx - stem_w / 2, top_y - stem_h * 0.6, cx + stem_w / 2, top_y + stem_h * 0.5),
        radius=stem_w / 2,
        fill=(110, 70, 30, 255),
    )

    leaf_w, leaf_h = size * 0.11, size * 0.06
    leaf = Image.new("RGBA", (int(leaf_w), int(leaf_h)), (0, 0, 0, 0))
    ImageDraw.Draw(leaf).ellipse((0, 0, leaf_w, leaf_h), fill=(52, 199, 89, 255))
    leaf = leaf.rotate(-28, expand=True, resample=Image.BICUBIC)
    layer.alpha_composite(
        leaf, (int(cx - leaf.width * 0.82), int(top_y - leaf.height * 0.78))
    )
    return layer


def build_cup(size, cup_ratio=0.74, rim_ratio=0.045, fill_level=0.56, with_leaf=True):
    """흰 컵(원) + 안쪽 오렌지 웨이브 액체를 그린 정사각 투명 레이어를 반환."""
    layer = Image.new("RGBA", (size, size), (0, 0, 0, 0))

    cup_d = size * cup_ratio
    cx = cy = size / 2
    cup_box = (cx - cup_d / 2, cy - cup_d / 2, cx + cup_d / 2, cy + cup_d / 2)

    # 컵 그림자(약간 아래로 오프셋된 블러 타원)로 입체감 부여.
    shadow = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    shadow_draw = ImageDraw.Draw(shadow)
    offset = size * 0.02
    shadow_draw.ellipse(
        (cup_box[0], cup_box[1] + offset, cup_box[2], cup_box[3] + offset),
        fill=(120, 60, 0, 100),
    )
    shadow = shadow.filter(ImageFilter.GaussianBlur(size * 0.022))
    layer = Image.alpha_composite(layer, shadow)

    if with_leaf:
        layer = Image.alpha_composite(
            layer, draw_leaf(size, cx, cup_box[1] + cup_d * 0.045)
        )

    # 흰 컵 본체.
    cup_layer = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    ImageDraw.Draw(cup_layer).ellipse(cup_box, fill=CREAM)
    layer = Image.alpha_composite(layer, cup_layer)

    # 안쪽 액체(림 두께만큼 인셋된 원 마스크로 클리핑).
    inner_d = cup_d * (1 - rim_ratio)
    inner_box = (
        cx - inner_d / 2,
        cy - inner_d / 2,
        cx + inner_d / 2,
        cy + inner_d / 2,
    )
    mask = Image.new("L", (size, size), 0)
    ImageDraw.Draw(mask).ellipse(inner_box, fill=255)

    baseline = inner_box[1] + inner_d * (1 - fill_level)
    amp = inner_d * 0.05

    back = draw_wave_layer(size, baseline - amp * 0.3, amp * 1.1, math.pi * 1.15,
                            (*CITRUS_YELLOW[:3], 235))
    front = draw_wave_layer(size, baseline, amp, math.pi * 0.15, FRESH_ORANGE)

    liquid = Image.alpha_composite(back, front)
    liquid.putalpha(Image.composite(liquid.split()[3], Image.new("L", (size, size), 0), mask))
    layer = Image.alpha_composite(layer, liquid)

    # 액체 위 하이라이트(길쭉한 광택 하이라이트, 살짝 기울여서 유리 질감 강조).
    hl_w, hl_h = inner_d * 0.42, inner_d * 0.10
    highlight_small = Image.new("RGBA", (int(hl_w), int(hl_h)), (0, 0, 0, 0))
    ImageDraw.Draw(highlight_small).ellipse((0, 0, hl_w, hl_h), fill=(255, 255, 255, 55))
    highlight_small = highlight_small.rotate(-18, expand=True, resample=Image.BICUBIC)
    highlight = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    highlight.alpha_composite(
        highlight_small,
        (int(inner_box[0] + inner_d * 0.12), int(baseline + inner_d * 0.10)),
    )
    highlight.putalpha(Image.composite(highlight.split()[3], Image.new("L", (size, size), 0), mask))
    layer = Image.alpha_composite(layer, highlight)

    # 컵 테두리(림) 스트로크로 유리 경계를 또렷하게.
    rim = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    ImageDraw.Draw(rim).ellipse(cup_box, outline=(255, 255, 255, 235), width=round(size * 0.006))
    layer = Image.alpha_composite(layer, rim)

    return layer


def main():
    # 1) iOS/Android 레거시 아이콘: 불투명 그라데이션 배경 + 컵.
    bg = radial_gradient_bg(SIZE)
    cup_full = build_cup(SIZE, cup_ratio=0.74)
    full = Image.alpha_composite(bg, cup_full).convert("RGB")
    full = full.resize((1024, 1024), Image.LANCZOS)
    full.save("assets/icon/icon_full.png")

    # 2) Android 적응형 아이콘 전경: 투명 배경 + 세이프존(약 66%)에 맞춘 컵.
    # 마스크에 따라 위쪽이 잘릴 수 있는 기기를 고려해 잎사귀는 생략.
    fg_layer = build_cup(SIZE, cup_ratio=0.62, with_leaf=False)
    fg_layer = fg_layer.resize((1024, 1024), Image.LANCZOS)
    fg_layer.save("assets/icon/icon_foreground.png")

    print("done")


if __name__ == "__main__":
    main()
