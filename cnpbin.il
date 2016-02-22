;; copyleft ebecheto
; load("cnpbin.il")
unless(fboundp('abBinaryStrToInt) load("abBinaryStrToInt.il"))
;; load "abBinaryStrToInt.il"


;; nrack=8
;; nbit=4


;; for(i 1 2**8
;; sum=0
;; for(j 0 nrack-1
;; sum=sum + ((i>>j)&1)
;; )
;; when(sum==nbit printf("%d \t= %s\n" i abIntToBinaryStr(i 8)))
;; )


;; nb=40
;; abIntToBinaryStr(nb 8);=> "01010"
;; sum=0
;; for(j 1 8 sum=sum + nb>>j&1 )
;; foreach(mapcar j linRg(1 8 1)  nb>>j&1 )
;; foreach(mapcar j linRg(1 8 1)  bitfield1(nb j) )



;; nrack=8
;; nbit=3

;; for(i 1 2**nrack
;; sum=0
;; for(j 0 nrack-1 sum=sum+((i>>j)&1))
;; when(sum==nbit printf("%d \t= %s\n" i abIntToBinaryStr(i 8)))
;; )

defun(cnpbin (@optional (nbit 4) (nrack 8) (verb nil))
let((sum res)
for(i 1 2**nrack sum=0
for(j 0 nrack-1 sum=sum+((i>>j)&1))
when(sum==nbit res=append(res list(i))
when(verb printf("%d \t= %s\n" i abIntToBinaryStr(i nrack)))
)
)
res))

;; cnpbin(6 10)
;; cnpbin(3 4 t)


;; c48bin=cnpbin()
;; length(c48bin)
;; nth(0 c48bin)


;; nth(codeS list(15 23 27 29 30 39 43 45 46 51 53 54 57 58 60 71 75 77 78 83 85 86 89 90 92 99 101 102 105 106 108 113 114 116 120 135 139 141 142 147 149 150 153 154 156 163 165 166 169 170 172 177 178 180 184 195 197 198 201 202 204 209 210 212 216 225 226 228 232 240))

;; nth(codeF list(15 23 27 29 30 39 43 45 46 51 53 54 57 58 60 71 75 77 78 83 85 86 89 90 92 99 101 102 105 106 108 113 114 116 120 135 139 141 142 147 149 150 153 154 156 163 165 166 169 170 172 177 178 180 184 195 197 198 201 202 204 209 210 212 216 225 226 228 232 240))

;; cnpbin(6 8);=> (63 95 111 119 123 125 126 159 175 183 187 189 190 207 215 219 221 222 231 235 237 238 243 245 246 249 250 252)
;; length(cnpbin(6 8));=> 28

;; println(cnpbin(8 10));=>45 elements
;; (255 383 447 479 495 503 507 509 510 639 703 735 751 759 763 765 766 831 863 879 887 891 893 894 927 943 951 955 957 958 975 983 987 989 990 999 1003 1005 1006 1011 1013 1014 1017 1018 1020)

;; cnpbin(2 10 t)
;; cnpbin(2 7 t)
;; cnpbin(3 7 t)
;; cnpbin(5 7 t)
;; aa=cnpbin(5 11 t)
;; foreach(mapcar a aa abIntToBinaryStr(a 11)
