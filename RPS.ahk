; Rock Paper Scissors game

SetWorkingDir %A_ScriptDir%

Gui, Add, Tab, x2 y359 w470 h20 , RPS|RPSLS ;add the tabs to the bottom left to change between rps and rpsls
Gui, Tab, RPS ;designates here after that these are on the RPS tab
Gui, Add, Text, x2 y-1 w480 h60 +center , Choose rock, paper, or scissors.`nThe game will choose rock, paper, or scissors randomly itself, and then you will receive a prompt notifying you if you won. Try to be the very best that no one ever was. Good luck!`nWhen you are done, maybe it is time to try RPSLS?
Gui, Add, Picture, x12 y219 w140 h140 gClickR, %A_WorkingDir%\rock.png
Gui, Add, Picture, x162 y69 w140 h140 gClickP, %A_WorkingDir%\paper.png
Gui, Add, Picture, x312 y219 w140 h140 gClickS, %A_WorkingDir%\scissors.png
Gui, Add, Button, x189 y300 w100 h50 +center gScoreRPS, Score ;this button tells the score. The gTag tells ahk that there is a function defined below named ScoreRPS that needs to be looked at when acted upon
Gui, Tab, RPSLS ;functions after this are on the RPSLS tab
Gui, Add, Picture, x89 y219 w140 h140 gClickSpock , %A_WorkingDir%\spock.png
Gui, Add, Picture, x24 y75 w140 h140 gClickLizard , %A_WorkingDir%\lizard.png
Gui, Add, Picture, x167 y1 w140 h140 gClickScissors , %A_WorkingDir%\scissors.png
Gui, Add, Picture, x312 y75 w140 h140 gClickPaper , %A_WorkingDir%\paper.png
Gui, Add, Picture, x238 y219 w140 h140 gClickRock , %A_WorkingDir%\rock.png
Gui, Add, Button, x190 y150 w100 h50 +center gScoreRPSLS, Score

Gui, Show, x541 y194 h379 w479, Rock! Paper! Scissors! Shoot... ;gui window render, location, height and width, title
Return

ScoreRPS: ;this is used to keep record of the number of instances of a win or loss after winning or losing
{
word1 = Won ;words we are looking for in script
word2 = Lost
file = %A_WorkingDir%\rps-score.txt ;file we are working off of

Loop, read, %file% ;read file. This is a loop so that it reads every line, also keeps document open for performance boost
{
  loop, parse, A_LoopReadLine, %A_Tab%%A_Space%
  {  
    if A_LoopField = %word1% ;if this finds Won, it adds to the count by 1
      count++
  }    
}
msgbox, You "%word1%" %count% times 
count = 0 ;count is reset here to prevent it from carrying over to losses
Loop, read, %file%
{
  loop, parse, A_LoopReadLine, %A_Tab%%A_Space%
  {  
    if A_LoopField = %word2%
      count++
  }    
}
msgbox, You "%word2%" %count% times 
count = 0
return
}
return

ClickP: ;name of function in gTag NOTE: pictures are automatically set to function on click, so a click on rock will make ClickR work
{
gui, submit, nohide
Random, Choice, 1, 3
if Choice = 1
	{
	msgbox, The computer picked rock. You win!
	FileAppend, Won%A_Space%, %A_WorkingDir%\rps-score.txt
	return
	}
if Choice = 2
	{
	msgbox, The computer picked scissors. You lose!
	FileAppend, Lost%A_Space%, %A_WorkingDir%\rps-score.txt
	return
	}
if Choice = 3
	msgbox, The computer picked paper. It's a tie!
return
}
return

ClickR:
{
gui, submit, nohide
Random, Choice, 1, 3
if Choice = 1
	msgbox, The computer picked rock. It's a tie!
if Choice = 2
	{
	msgbox, The computer picked scissors. You win!
	FileAppend, Won%A_Space%, %A_WorkingDir%\rps-score.txt
	return
	}
if Choice = 3
	{
	msgbox, The computer picked paper. You lose!
	FileAppend, Lost%A_Space%, %A_WorkingDir%\rps-score.txt
	return
	}
}
return

ClickS:
{
gui, submit, nohide
Random, Choice, 1, 3
if Choice = 1
	{
	msgbox, The computer picked rock. You lose!
	FileAppend, Lost%A_Space%, %A_WorkingDir%\rps-score.txt
	return
	}
if Choice = 2
	msgbox, The computer picked scissors. It's a tie!
if Choice = 3
	{
	msgbox, The computer picked paper. You win!
	FileAppend, Won%A_Space%, %A_WorkingDir%\rps-score.txt
	return
	}
}
return

ScoreRPSLS: ;this is used to keep record of the number of instances of a win or loss after winning or losing. Why is this here twice? Once to read the first page, and again to read the second page. This way we can keeps our wins in both separate. 
{
word1 = Won ;words we are looking for in script
word2 = Lost
file = %A_WorkingDir%\rpsls-score.txt ;file we are working off of

Loop, read, %file% ;read file. This is a loop so that it reads every line, also keeps document open for performance boost
{
  loop, parse, A_LoopReadLine, %A_Tab%%A_Space%
  {  
    if A_LoopField = %word1% ;if this finds Won, it adds to the count by 1
      count++
  }    
}
msgbox, You "%word1%" %count% times 
count = 0 ;count is reset here to prevent it from carrying over to losses
Loop, read, %file%
{
  loop, parse, A_LoopReadLine, %A_Tab%%A_Space%
  {  
    if A_LoopField = %word2%
      count++
  }    
}
msgbox, You "%word2%" %count% times 
count = 0 ;count is reset here to prevent it from carrying over to wins if clicked again
return
}
return

ClickSpock:
{
gui, submit, nohide ;submits decisions made in GUI (probably not necessary in this form)
Random, Choice, 1, 5 ;uses random function, variable, low, high (see note at bottom)
if Choice = 1 ;because we gave a spread of 1-5 we need to assign values to these choices 1 is rock each time
	{
	msgbox, The computer picked rock. Spock vaporizes rock and you win!
	FileAppend, Won%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
if Choice = 2
	{
	msgbox, The computer picked scissors. Spock smashes scissors and you win!
	FileAppend, Won%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
if Choice = 3
	{
	msgbox, The computer picked paper. Paper disproves Spock and you lose...
	FileAppend, Lost%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
if Choice = 4
	msgbox, The computer picked spock. In the alternate timeline these two are buddies, so TIE.
if Choice = 5
	{
	msgbox, The computer picked lizard. Lizard poisons Spock and you lose...
	FileAppend, Lost%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
return
}
return

ClickLizard:
{
gui, submit, nohide
Random, Choice, 1, 5
if Choice = 1
	{
	msgbox, The computer picked rock. Rock crushes lizard and you lose...
	FileAppend, Lost%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
if Choice = 2
	{
	msgbox, The computer picked scissors. Scissors decapitates lizard and you lose...
	FileAppend, Lost%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
if Choice = 3
	{
	msgbox, The computer picked paper. Lizard eats paper and you win!
	FileAppend, Won%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
if Choice = 4
	{
	msgbox, The computer picked spock. Lizard poisons Spock and you win!
	FileAppend, Won%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
if Choice = 5
	msgbox, The computer picked lizard. Lizards decide to end the war. Tie.
return
}
return

ClickRock:
{
gui, submit, nohide
Random, Choice, 1, 5
if Choice = 1
	msgbox, The computer picked rock. TIE.
if Choice = 2
	{
	msgbox, The computer picked scissors. You win!
	FileAppend, Won%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
if Choice = 3
	{
	msgbox, The computer picked paper. You lose...
	FileAppend, Lost%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
if Choice = 4
	{
	msgbox, The computer picked spock. Spock vaporizes rock and you lose...
	FileAppend, Lost%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
if Choice = 5
	{
	msgbox, The computer picked lizard. Rock crushes lizard and you win!
	FileAppend, Won%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
return
}
return

ClickPaper:
{
gui, submit, nohide
Random, Choice, 1, 5
if Choice = 1
	{
	msgbox, The computer picked rock. You win!
	FileAppend, Won%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
if Choice = 2
	{
	msgbox, The computer picked scissors. You lose...
	FileAppend, Lost%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
if Choice = 3
	msgbox, The computer picked paper. TIE
if Choice = 4
	{
	msgbox, The computer picked spock. Paper disproves Spock and you win!
	FileAppend, Won%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
if Choice = 5
	{
	msgbox, The computer picked lizard. Lizard eats paper and you lose...
	FileAppend, Lost%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
return
}
return

ClickScissors:
{
gui, submit, nohide
Random, Choice, 1, 5
if Choice = 1
	{
	msgbox, The computer picked rock. You lose!
	FileAppend, Lost%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
if Choice = 2
	msgbox, The computer picked scissors. It's a tie!
if Choice = 3
	{
	msgbox, The computer picked paper. You win!
	FileAppend, Won%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
if Choice = 4
	{
	msgbox, The computer picked spock. Spock smashes scissors and you lose...
	FileAppend, Lost%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
if Choice = 5
	{
	msgbox, The computer picked lizard. Scissors decapitates lizard and you win!
	FileAppend, Won%A_Space%, %A_WorkingDir%\rpsls-score.txt
	return
	}
return
}
return

GuiClose:
ExitApp
return

/*
This function uses the Mersenne Twister random number generator, MT19937, written by Takuji Nishimura and Makoto Matsumoto, Shawn Cokus, Matthe Bellew and Isaku Wada.

The Mersenne Twister is an algorithm for generating random numbers. It was designed with consideration of the flaws in various other generators. The period, 219937-1, and the order of equidistribution, 623 dimensions, are far greater. The generator is also fast; it avoids multiplication and division, and it benefits from caches and pipelines. For more information see the inventors' web page at www.math.keio.ac.jp/~matumoto/emt.html

Copyright (C) 1997 - 2002, Makoto Matsumoto and Takuji Nishimura, All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
The names of its contributors may not be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Do NOT use for CRYPTOGRAPHY without securely hashing several returned values together, otherwise the generator state can be learned after reading 624 consecutive values.

When you use this, send an email to: matumoto@math.keio.ac.jp with an appropriate reference to your work. It would be nice to CC: rjwagner@writeme.com and Cokus@math.washington.edu when you write.
*/