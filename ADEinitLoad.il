
; load("~/Skill/ADEinitLoad.il")

procedure(
ADEinitLoad()
; let((gg gcw)

deInstallApp( getCurrentWindow() "analogArtist-Schematic")
(sevLoadState (sevSession getCurrentWindow()))
(hiFormApply (sevForm (sevSession getCurrentWindow()) 'load))
(hiFormCancel (sevForm (sevSession getCurrentWindow()) 'load))
sevSelectResults((sevSession getCurrentWindow()))
hiFormApply(hiGetCurrentForm())
hiFormCancel(hiGetCurrentForm())
;); fin let
); fin procedure


;; aaa = getCurrentWindow()~>sevSession~>loadForm   
;; (sevSession getCurrentWindow())~>forms~>_doneAction  
;; gg = (sevForm (sevSession getCurrentWindow()) 'load)
;; hiFormApply(gg)
;; hiFormCancel(gg)
;;<== renvoie l'identifiant de la current form
;<== MenuADE:Session->LoadState
;; deOpen(getCurrentWindow() "analogArtist-Schematic") ;;<== marche pas
;;getCurrentWindow()~>sevSession~>windowForm~>? ;;<== renvoie l'identifiant de la from ADE
;; getCurrentWindow()~>sevSession~>loadForm~>hiFormSym ;;==>i.e. : sevLoadForm17
;; ^^ DANGER, n'active pas la form ... ==> PB pour utiliser ensuite hiGetCurrentForm
;bbb = getCurrentWindow()~>sevSession~>loadForm   ;;<== renvoie l'identifiant de la current form
;;==> formStruct@0xe895b78
;; getCurrentWindow()~>sevSession~>forms~>?
;; hiGetCurrentForm( )~>hiFormSym ;;==> sevLoadForm3
;;hiGetCurrentForm()~>stateName~>items;;<== Wrong : ne me donne pas l'existence d'un item
;;hiGetCurrentForm()~>stateName~>defValue
;; car((member 'sevLoadForm3 hiFormList( )))
; hiFormDone(hiGetCurrentForm()) ;;<== remplace : hiFormDone(sevLoadForm3)
;; vaut mieux apply puis cancel, comme ca, qd il n'y a pas d'ancien state, la fenetre se ferme qd meme


;hiFormApply(getCurrentWindow()~>sevSession~>loadForm)
;hiFormCancel(getCurrentWindow()~>sevSession~>loadForm)
;; hiFormCancel(hiGetCurrentForm());; <== la form existe mais n'est pas active => repartir du descripteur de getCurrentWindow. hi veux dire Human Interface, la on fait du script,
;;hiFormDone(hiGetCurrentForm());;<==  remplace hiFormDone(selectResultsForm3)
;(hiFormDone (sevSelectResults (sevSession getCurrentWindow())))

;hiSetBindKey( "Schematics" "<Key>a" "(if (sevSession getCurrentWindow()) (sevCreateMainWindow (sevSession getCurrentWindow())) deInstallApp(getCurrentWindow() \"analogArtist-Schematic\"))" )  ;; <== ouvre ADE s'il n'est pas ouvert, sinon, le mets sur le devant des fenetres

