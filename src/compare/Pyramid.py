"""
Python approach to pyramid calculation exercise to compare with assembly
outputs.

See pyramid.asm for an information about the task.
"""

def main():
    a_sides: list[int] = [
        10, 14, 13, 37, 54,
        31, 13, 20, 61, 36,
        14, 53, 44, 19, 42,
        27, 41, 53, 62, 10,
        19, 18, 14, 10, 15,
        15, 11, 22, 33, 70,
        15, 23, 15, 63, 26,
        24, 33, 10, 61, 15,
        14, 34, 13, 71, 81,
        38, 13, 29, 17, 93
    ]
    s_sides: list[int] = [
        1233, 1114, 1773, 1131, 1675,
        1164, 1973, 1974, 1123, 1156,
        1344, 1752, 1973, 1142, 1456,
        1165, 1754, 1273, 1175, 1546,
        1153, 1673, 1453, 1567, 1535,
        1144, 1579, 1764, 1567, 1334,
        1456, 1563, 1564, 1753, 1165,
        1646, 1862, 1457, 1167, 1534,
        1867, 1864, 1757, 1755, 1453,
        1863, 1673, 1275, 1756, 1353
    ]
    heights: list[int] = [
        14145, 11134, 15123, 15123, 14123,
        18454, 15454, 12156, 12164, 12542,
        18453, 18453, 11184, 15142, 12354,
        14564, 14134, 12156, 12344, 13142,
        11153, 18543, 17156, 12352, 15434,
        18455, 14134, 12123, 15324, 13453,
        11134, 14134, 15156, 15234, 17142,
        19567, 14134, 12134, 17546, 16123,
        11134, 14134, 14576, 15457, 17142,
        13153, 11153, 12184, 14142, 17134
    ]

    length: int = 50

    area_min: int = 0
    area_max: int = 0
    area_sum: int = 0
    area_average: int = 0

    volume_min: int = 0
    volume_max: int = 0
    volume_sum: int = 0
    volume_average: int = 0

    areas: list[int] = []
    volumes: list[int] = []

    for i in range(length):
        a: int = a_sides[i]
        s: int = s_sides[i]
        h: int = heights[i]

        area: int = 2 * a * s + a**2
        volume: int = (a**2 * h) // 3

        areas.append(area)
        volumes.append(volume)

        area_sum += area
        volume_sum += volume

        if i == 0:
            area_min = area
            area_max = area
            volume_min = volume
            volume_max = volume
        else:
            if area < area_min:
                area_min = area
            elif area > area_max:
                area_max = area

            if volume < volume_min:
                volume_min = volume
            elif volume > volume_max:
                volume_max = volume

    area_average = area_sum // length
    volume_average = volume_sum // length

    print(f"{area_min=}")
    print(f"{area_max=}")
    print(f"{area_sum=}")
    print(f"{area_average=}")

    print()
    print("------------------------")
    print()

    print(f"{volume_min=}")
    print(f"{volume_max=}")
    print(f"{volume_sum=}")
    print(f"{volume_average=}")

    print()
    print("------------------------")
    print()

    print(f"{areas=}")

    print()
    print("------------------------")
    print()

    print(f"{volumes=}")


if __name__ == "__main__":
    main()
