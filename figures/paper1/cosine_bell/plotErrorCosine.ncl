;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   (C) 2011 Evan Bollig
;;      Plot filled contours of RBF-FD solutions on the sphere.
;;      Scattered data (X,Y,Z) on sphere
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;
; loads the required NCL commands used below (think importing packages in python)
;;;;;;;
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"


;
; Create a workstation.
;
NCGM=0          ; PNG
X11=1           ; X11
PS=1            ; EPS
PDF=0           ; PDF

; FILE NAME FOR EXPORTING
exportName = "tracer"


;
;  Main program
;
begin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Setup a Rendering Context (WKS=Workstation) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


if (NCGM .eq. 1) then
;wks = gsn_open_wks("ncgm","tracer")
wks = gsn_open_wks("png",exportName)
end if
if (X11 .eq. 1) then
wks = gsn_open_wks("x11",exportName)
end if
if (PS .eq. 1) then
wks_type = "eps"
wks_type@wkOrientation = "portrait"
wks = gsn_open_wks(wks_type,exportName)
end if
if (PDF .eq. 1) then
wks = gsn_open_wks("pdf",exportName)
end if

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   Load Data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

fdat            = "./AbsoluteError.dat"     ; ScalarField
xdat            = "./grid.dat"              ; Nodes
gdat            = "./geometry.dat"          ; Description of Nodes file (dimensions)


gd = asciiread(gdat,(/2/),"integer")
m = gd(0) 
N = gd(1) 

data = asciiread(fdat,(/N/),"float")
nodes = asciiread(xdat,(/N,3/),"float")

X = nodes(:,0); 
Y = nodes(:,1); 
Z = nodes(:,2);

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   Convert to Lat/Lon Coords
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

latlon = csc2s(X,Y,Z)
rlat = latlon(0,:)
rlon = latlon(1,:)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   Color OPTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;gsn_define_colormap(wks,"wh-bl-gr-ye-re")
gsn_define_colormap(wks,"WhViBlGrYeOrRe")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  OPTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

res                         = True

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   MAP OPTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

res@mpProjection            = "Orthographic"    ; Change the map projection.
res@mpCenterLonF            =  180. + 90.       ; Rotate the projection.
res@mpCenterLatF            =  0.0              ; Rotate the projection.
res@mpOutlineOn             = False             ; Show continents

res@mpDataBaseVersion       = "MediumRes"
res@mpLimitMode             = "LatLon"
res@mpCenterLatF            = 0                 ; These two control view direction
res@mpCenterLonF            = -90          

res@mpGridAndLimbOn         = True              ; Outline the sphere with a circle
res@mpGridSpacingF          = 0.0
res@mpGridLineDashPattern   = 1
res@mpLimbLineColor         = 1
res@mpGridLineColor         = -1                ; -1 makes grid transparent, [0,1] give gray color
res@mpGreatCircleLinesOn    = True
res@mpPerimLineThicknessF   = 1.
res@mpLimbLineThicknessF   = 1.0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   ContourMap OPTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

res@cnFillOn                = True              ; color plot desired
;res@cnLevelSelectionMode   = "ManualLevels"    ; Define your own
res@cnLinesOn               = False
res@cnLineLabelsOn          = False
res@cnMaxLevelCount         = 16                ; Number of Contours
res@cnVerboseTriangleInfo   = False 

res@cnInfoLabelOn           = False             ; Print summary of contour range as label
res@cnLineLabelsOn          = False             ; No cotour labels 
res@cnLabelBarEndStyle      = "IncludeMinMaxLabels"
res@cnLineThicknessF        = 0.5               ; Double the line thickness.
res@cnFillOn                = True
res@cnRasterSmoothingOn     = True

;res@cnMinLevelValF          = 0.                ; Data Min/Max (for color range)
;res@cnMaxLevelValF          = 1.                ; Comment to auto range

res@cnExplicitLabelBarLabelsOn = True; 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   ColorBar (LabelBar) OPTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

res@lbAutoManage            = False
res@lbBoxLinesOn            = True 
res@lbLabelAutoStride       = False 
res@lbOrientation           =  "vertical"
res@lbPerimOn               = False 

res@lbLabelStride           = 1       
;res@lbLabelFont             = 0
res@lbLabelFontHeightF      = 0.020 
;res@lbLabelFontThicknessF   = 1.
;res@lbBoxLineThicknessF     = 1.5
res@lbLabelAlignment       = "ExternalEdges"
;res@lbLabelAngleF          = -45
res@lbBoxMinorExtentF       = 0.15

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   PlotManager OPTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

res@pmLabelBarDisplayMode   = "Always"
res@pmLabelBarSide          = "right"
;res@pmLabelBarParallelPosF  =  0.5               ; CENTER the label
;res@pmLabelBarOrthogonalPosF=  -0.08
;res@pmLabelBarHeightF        =  .1              ; This is actually height of a horizontal bar
;res@pmLabelBarWidthF       =  0.6
;res@pmLabelBarKeepAspect    = True
;res@pmTickMarkDisplayMode   = "Always"         ; Show box around sphere


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   WINDOW OPTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;res@vpXF                    = 0.5    ; Change the size and location of the
;res@vpYF                    = 0.99   ; plot on the viewport.
;res@vpWidthF                = 0.8
;res@vpHeightF               = 0.8


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   Graphics OPTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

res@gsnFrame                = False             ; Flush the draw? 
res@gsnDraw                 = False 
res@gsnMaximize             = True              ; Fill Window with drawing 
res@gsnPaperOrientation     = "Portrait"
res@gsnSpreadColors         = True              ; These four shrink the colormap to the data 
res@gsnSpreadColorStart     = 0
res@gsnSpreadColorEnd       = -1         


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Generate A ContourMap
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

res@sfXArray                = rlon
res@sfYArray                = rlat

plot = new(2,graphic)
plot(0) = gsn_contour_map(wks,data,res)


;--------Second plot-----------------------------------
; Move the labelbar labels so they are centered under
; each box. This requires changing the labels as well.
;------------------------------------------------------

;
; Retrieve the contour levels used in previous plot so
; we can create new labels for the next two plots.
;
getvalues plot@contour
"cnLevels" : levels
end getvalues
nlevels = dimsizes(levels)
spacing = levels(1) - levels(0)

;---Use "BoxCenters" labelbar
res@lbLabelAlignment = "BoxCenters"
;
; Shift the levels over by half their spacing since we're
; going to center the labels under the labelbar boxes.
;
levels_plus1              = new(nlevels+1,float)
levels_plus1(0:nlevels-1) = levels-(spacing/2.)
levels_plus1(nlevels)     = levels_plus1(nlevels-1) + spacing

;--------Second plot-----------------------------------
; Add min/max labels to end of labelbar
;------------------------------------------------------

;---Use "ExternalEdges" labelbar
res@lbLabelAlignment = "ExternalEdges"

;---Need one more string than what we had before.
delete(res@lbLabelStrings)

manualStride            = 2
levels_plus2            = new(nlevels+2,float)
levels_plus2(1:nlevels) = levels
levels_plus2(0)         = min(data) ; floor(min(data))
levels_plus2(nlevels+1) = max(data) ;ceil(max(data))

res@lbLabelStrings = sprintf("%3.1e",levels_plus2)

myLabelStrings = res@lbLabelStrings
endLabel = myLabelStrings(nlevels+1)
iter = 1
do while (iter .le. nlevels)
    do stride = 1,manualStride-1 
        myLabelStrings(iter) = ""
        iter = iter + 1
    end do 
    iter = iter + 1
end do
;; Should be plus 2 but we're starting at 0
myLabelStrings(nlevels+1) = endLabel

res@lbLabelStrings = myLabelStrings
print(myLabelStrings)

plot(1) = gsn_contour_map(wks,data,res)


;
; Now add some markers to show where the original 1D points are.
;
mkres = True
mkres@gsMarkerIndex           = 16    ; Filled dots
mkres@gsMarkerSizeF           = 0.001; 
dum = gsn_add_polymarker(wks,plot(1),rlon,rlat,mkres)

; 
; Add a title if necessary 
; 
txres = True
txres@txFontHeightF = 0.025
txres@txFontColor = 1
txres@txJust = "CenterCenter"
;gsn_text_ndc(wks, "DGP2: Sph Transport", 0.5, 0.95, txres)



;;;;;;;;;;;;;;;;;;;;;;;;
;; Exports the EPS file
;;;;;;;;;;;;;;;;;;;;;;;;
;draw(plot(0))
;frame(wks)
draw(plot(1))
frame(wks)


end
