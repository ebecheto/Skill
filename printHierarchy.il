    ignorelibs      "basic sample cmos8rf  cmrf8sf"
    hierarchy       t
    cell            "TDC_BRICK"
    library         "local_TDC_BRICK"
    plot            "cellview"

;; geGetWindowCellView()~>libName
;; ;=> "local_TDC_BRICK"
;; ddGetLibList()~>name
skipLibs=remove(geGetWindowCellView()~>libName ddGetLibList()~>name)
;=> ("analogLib" "sbaLib" "basic" "sample" "cmrf8sf" "esd8rf" "cmos8rf" "short_io" "US_8ths" "PRACTIC_32" "HSL_lib_wosubc_TRANSLATE" "PRACTIC_32_PRIMLIB" "1TEST_v18" "AAA" "Ed_CMOS8" "SLHC_v2" "SLHC_v1" "TDC" "avTech" "HSL_lib_11_02_28" "pacific" "FEAFS_V1_KIT17" "Ed_IBMv18" "GDS_import" "test_op" "cdsDefTechLib")


