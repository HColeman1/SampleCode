import random
 
NUM_DIGITS = 3
MAX_GUESS = 10

def getSecretNum():
 # Returns a string of unique random digits that is NUM_DIGITS long.
 numbers = list(range(10))
 random.shuffle(numbers)
 secretNum = ''
 for i in range(NUM_DIGITS):
     secretNum += str(numbers[i])
 return secretNum

def getClues(guess, secretNum):
     # Returns clues to the user.
     if guess == secretNum:
         return 'Great job! You got it!'

     clues = []
     for i in range(len(guess)):
         if guess[i] == secretNum[i]:
             clues.append('A number in right position')
         elif guess[i] in secretNum:
            clues.append('A correct number in wrong position')
     if len(clues) == 0:
         return 'No numbers are correct'

     clues.sort()
     return ' '.join(clues)

def isOnlyDigits(num):
     # Returns True if num is a string of only digits. Otherwise, returns
          #False.
    if num == '':
        return False

    for i in num:
        if i not in '0 1 2 3 4 5 6 7 8 9'.split():
            return False

    return True
print("I have a 3 digit number. It has no repeating digits. Can you guess it?")

while True:
    secretNum = getSecretNum()



    print('You have %s guesses to get it.' %
          (MAX_GUESS))

    guessesTaken = 1
    while guessesTaken <= MAX_GUESS:
         guess = ''
         while len(guess) != NUM_DIGITS or not isOnlyDigits(guess):
             print('Guess #%s: ' % (guessesTaken))
             guess = input()

         print(getClues(guess, secretNum))
         guessesTaken += 1

         if guess == secretNum:
             break
         if guessesTaken > MAX_GUESS:
             print('You ran out of guesses. The answer was %s.' %
                  (secretNum))

    print('Do you want to play again? (yes or no)')
     
    if not input().lower().startswith('y'):
        break
