def wobble(number: int):
    if number % 2 == 0:
        return number // 2
    return number * 3 + 1


def bouncing_numbers(start: int):
    numbers = [start]
    while start > 1 and len(numbers) < 8:
        start = wobble(start)
        numbers.append(start)
    return numbers


def alternate_case(text: str):
    result = ""
    for index, character in enumerate(text):
        if index % 2 == 0:
            result += character.upper()
        else:
            result += character.lower()
    return result


def count_vowels(text: str):
    count = 0
    for character in text.lower():
        if character in "aeiou":
            count += 1
    return count


def fizz_buzz(limit: int):
    word_mods = {
        3: "fizz",
        5: "buzz",
        8: "byte",
    }

    result: list[str] = []
    for number in range(1, limit + 1):
        words = ""
        for i, w in word_mods.items():
            words += "" if not number % i == 0 else w

            if words == "":
                result.append(str(number))
            else:
                result.append(words)

    return result


def reverse_words(text: str):
    words = text.split()
    return " ".join(reversed(words))


def main():
    phrase = "neovim makes the cursor dance"
    print(alternate_case(phrase))
    print(reverse_words(phrase))
    print(count_vowels(phrase))
    print(bouncing_numbers(7))
    print(fizz_buzz(100))


if __name__ == "__main__":
    main()
