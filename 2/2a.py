# lines = open('sample.txt').readlines()
lines = open('input.txt').readlines()
res = 0
for i, line in enumerate(lines):
    line_valid = True
    games = line.split(': ')[-1][:-1].split('; ')
    for game in games:
        game = game.split(', ')
        for move in game:
            move = move.split(' ')
            if move[1] == 'red' and int(move[0]) > 12:
                line_valid = False
                break
            if move[1] == 'green' and int(move[0]) > 13:
                line_valid = False
                break
            if move[1] == 'blue' and int(move[0]) > 14:
                line_valid = False
                break
        if not line_valid:
            break
    if line_valid:
        res += i + 1

print(res)
