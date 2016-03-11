/* abConcatWaveforms.il

Author     A.D.Beckett
Group      Custom IC (UK), Cadence Design Systems Ltd.
Language   SKILL
Date       Jan 08, 2009
Modified
By

Function to concatenate waveforms.

For example:

new=abConcatWaveforms(flip(sig) sig)

will produce a new waveform made out of a flipped version of
the input signal, glued to the original input signal.

***************************************************

SCCS Info: @(#) abConcatWaveforms.il 01/08/09.15:41:29 1.1

*/

/*****************************************************************
*                                                                *
*             (abConcatWaveforms (wave1 [waves...]))             *
*                                                                *
*  Function to concatenate a number of waveforms. The function   *
*   takes an arbitrary number of waveforms (assumed to all be    *
*  waveforms or families of the same number of dimensions), and  *
* concatenates the axes together. Note that care should be taken *
*  if the x-axes overlap, because this merely concatenates the   *
*              vectors without any checking at all.              *
*                                                                *
*****************************************************************/

(defun abConcatWaveforms (wave1 @rest waves)
   (let (xVec yVec newX newY newLen len)
     (cond
       ((drIsWaveform wave1)
        (setq newLen (drVectorLength (drGetWaveformXVec wave1)))
        (foreach wave waves
                (setq newLen (plus newLen
                                   (drVectorLength (drGetWaveformXVec wave))))
                )
        (setq newX (drCreateVec (drGetWaveformXType wave1) newLen))
        (setq newY (drCreateVec (drGetWaveformYType wave1) newLen))
        (foreach wave (cons wave1 waves)
                (setq xVec (drGetWaveformXVec wave))
                (setq yVec (drGetWaveformYVec wave))
                (setq len (drVectorLength xVec))
                (for pos 0 (sub1 len)
                     (drAddElem newX (drGetElem xVec pos))
                     (drAddElem newY (drGetElem yVec pos))
                     )
                )
        (drCreateWaveform newX newY)
        ) ; is waveform
       ((famIsFamily wave1)
        (apply 'famMap (constar 'abConcatWaveforms wave1 waves))
        ) ; is family
       (t
        (error "abConcatWaveforms - can't handle %L\n" wave1)
        )
       ) ; cond
     ) ; let
   ) ; defun