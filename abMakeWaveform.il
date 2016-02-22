/* abMakeWaveform.il

Author     A.D.Beckett
Group      Custom IC (UK), Cadence Design Systems Ltd.
Language   SKILL
Date       Jul 14, 1999 
Modified   Dec 10, 2007 
By         A.D.Beckett

A simple function to throw together waveforms for
test purposes. Usage:

abMakeWaveform('cos linRg(1 100 1)) => o_waveObj

Returns a waveform with x axis 1 to 100, in 1 steps, with y
axis the value of the x.

A more complex example:

abMakeWaveform(lambda((x) x*sin(x)) linRg(-40 40 0.1))

Can be plotted in OCEAN using plot(var).

Also supports the first argument being a list of y values:

abMakeWaveform('(5 6 7) '(1 2 3))

Note the lists must be equal length.

An optional third argument which is the data type may be supplied,
e.g. 'double (default) 'single etc. Finally a fourth argument
may be given if the x-axis wants to be a different type. For example
for bar graphs:

abMakeWaveform('(1 -2 4) '("NOM" "SLOW" "FAST") 'double 'string)

***************************************************

SCCS Info: @(#) abMakeWaveform.il 12/10/07.13:48:06 1.4

*/

/***************************************************************
*                                                              *
* The generic function takes a function object, or the name of *
*      a function (a symbol) and calls that function for       *
*   each of the x values. This would be nice if it could be    *
*    done as a method, but the problem is that you can only    *
*   have a method specialised on user defined functions, not   *
*                      binary functions.                       *
*                                                              *
***************************************************************/

(defgeneric abMakeWaveform (func xvalues @optional (yDataType 'double) 
    xDataType)
  (let (xVec yVec wave)
       (setq wave (drCreateEmptyWaveform))
       (unless xDataType (setq xDataType yDataType))
       (setq xVec (drCreateVec xDataType xvalues))
       (setq yVec (drCreateVec yDataType (mapcar func xvalues)))
       (drPutWaveformXVec wave xVec)
       (drPutWaveformYVec wave yVec)
       wave
       ))

/****************************************************************
*                                                               *
* A method is defined to allow the first argument to be a list, *
*               and do something different there.               *
*                                                               *
****************************************************************/

(defmethod abMakeWaveform ((yvalues list) xvalues @optional 
    (yDataType 'double) xDataType)
  (let (xVec yVec wave)
       (when
        (and (listp xvalues) (equal (length xvalues) (length yvalues)))
        (setq wave (drCreateEmptyWaveform))
        (unless xDataType (setq xDataType yDataType))
        (setq xVec (drCreateVec xDataType xvalues))
        (setq yVec (drCreateVec yDataType yvalues))
        (drPutWaveformXVec wave xVec)
        (drPutWaveformYVec wave yVec)
        wave
        )
       ))

