Haskell Uncut - Ruby Quiz #7 - Countdown
========================================

Result of me live-coding [Ruby Quiz #7](http://www.rubyquiz.com/quiz7.html) - Implement the "numbers round" game from the UK quiz show "Countdown".

You can see the video at [Haskell Uncut](http://youtube.com/user/entirelysubjective)

This took me so much longer than I had hoped. I guess I was just a little tired after a hard day's work.

### Timing (to calculate first exact solution)

In my VirtualBox the program runs ca. 0.2 seconds to deliver the first exact solution.


### Improving Performance

After profiling the program, I saw that the list functions don't seem to be the problem.

Interestingly, most time is spent in "tDiv" and "tMinus", so actually in creating the "Term" values and calculating their value. Another idea would be to use memoization to gain some speed.

All in all, this version seems to be relatively fast already. There is a good chance that "Fractional" is quite slow, but I'm not sure how else to work with fractions exactly...
