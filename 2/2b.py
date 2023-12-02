# lines = open('sample.txt').readlines()
lines = open('input.txt').readlines()
res = 0
for i, line in enumerate(lines):

    min_red, min_green, min_blue = 0, 0, 0

    games = line.split(': ')[-1][:-1].split('; ')

    for game in games:
        game = game.split(', ')
        for move in game:
            move = move.split(' ')
            if move[1] == 'red': min_red = max(min_red, int(move[0]))
            if move[1] == 'green': min_green = max(min_green, int(move[0]))
            if move[1] == 'blue': min_blue = max(min_blue, int(move[0]))

    res += min_red * min_green * min_blue

print(res)
