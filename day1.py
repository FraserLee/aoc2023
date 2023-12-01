print('hello world')
import re

# read lines from input.txt
# with open('input.txt') as f:
# # with open('sample.txt') as f:
#     lines = f.readlines()
#     sum = 0
#     for line in lines:
#         # replace all word digits with number version
#         match = re.search(r'one|two|three|four|five|six|seven|eight|nine', line)
#         if match:
#             digit = match.group(0)
#             for i, d in enumerate(['one', 'two', 'three', 'four', 'five', 'six', 
#                                    'seven', 'eight', 'nine']):
#                 if digit == d:
#                     line = line.replace(d, str(i+1), 1)
#                     break
#
#         line = line[::-1]
#         match = re.search(r'eno|owt|eerht|ruof|evif|xis|neves|thgie|enin', line)
#         if match:
#             digit = match.group(0)
#             for i, d in enumerate(['eno', 'owt', 'eerht', 'ruof', 'evif', 'xis', 
#                                    'neves', 'thgie', 'enin']):
#                 if digit == d:
#                     line = line.replace(d, str(i+1), 1)
#                     break
#
#         line = line[::-1]
#
#
#         print(line)
#         line = [x for x in line if x in '123456789']
#         print(int(line[0]) * 10 + int(line[-1]))
#         sum += int(line[0]) * 10 + int(line[-1])
#
#     print(sum)

with open('input.txt') as f:
# with open('sample.txt') as f:
    lines = f.readlines()
    sum = 0
    digits = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
    for line in lines:
        first = re.search(r'one|two|three|four|five|six|seven|eight|nine|1|2|3|4|5|6|7|8|9', line)
        if first:
            first = first.group(0)
            if first in digits:
                first = digits.index(first) + 1
            else:
                first = int(first)
        else:
            assert False

        second = re.search(r'eno|owt|eerht|ruof|evif|xis|neves|thgie|enin|1|2|3|4|5|6|7|8|9', line[::-1])

        if second:
            second = second.group(0)[::-1]
            if second in digits:
                second = digits.index(second) + 1
            else:
                second = int(second)

        else:
            assert False

        sum += first * 10 + second
    print(sum)




        
