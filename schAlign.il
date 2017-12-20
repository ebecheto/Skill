;; copyleft ebecheto
ineed('(bBoxWidth bBoxHeight prBoundInstList2Move))

;; inst=css()

;; inst~>??
;; insts=nil

defun( schAlign (@optional (insts nil)(HV t))
let((prBs point itrans XY0 bBox prB  list2sort iBox obj headSort sorted prBss)
unless(insts insts=geGetSelectedSet())
prBs=foreach(mapcar inst insts
point=inst~>xy
itrans=inst~>transform||list(inst~>xy car(inst~>tileArray) 1.0);<= mosaic patch
XY0=dbTransformPoint(point itrans)
;bBox=inst~>master~>prBoundary~>bBox
bBox=inst~>master~>bBox
prB=dbTransformBBox(bBox||list(0:0 0:0) itrans)
; list(X0Y0 db:inst)
list(prB inst)
)
HV=t
; pr=car( prBs );=> (((0.0 1145.0) (115.0 1260.0)) db:0x158b49e8)
list2sort=foreach(mapcar pr prBs 
iBox=nth(0 pr);=> ((115.0 1145.0) (125.0 1260.0))
obj=nth(1 pr);<= instance;=> db:0x158b49e4
headSort=if(HV caar(iBox) cadar(iBox)); <= X0 sinon Y0
list(headSort pr))
sorted=sortcar(list2sort 'lessp)
prBss=foreach(mapcan s sorted cdr(s))
;; length(list2sort) ;; length(prBs)
prBoundInstList2Move(prBss)
))

;; ;; DANGER is a cell has a ~>parent properties, moving one => moving the other
;; ;; => check if parent~>nil in the selection !
;; foreach(mapcar g geGetSelectedSet() g~>parent)
;; foreach(mapcar g geGetSelectedSet() when(g~>parent g~>parent==nil))
;; This was why the cadence Align function was not working properly i suppose.

;; TODO : vierfy precision !! bBox=1212.0 <= only .0 1 digit aftec comma precision is not enough.

