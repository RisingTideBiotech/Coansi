//When changing the default options on the variables, make sure you copy the format [punctuation, spaces, case] and words exactly as seen in the options that follow the semicolon for that variable, commas separate options

//RBG_	RadioButtonGroup	"string"
//CB_	Checkbox			true || false
//S_	Slider				1
//C_	Choice				"string"
//N_	Number				1

//Coansi  |  Step 1. Stack Preparation
var RBG_img1 = "Flatten dual channels";		//"Flatten dual channels","Extract green channel only","Extract red channel only","Undo flatten","None" [Stack Preparation for Stereology]
var CB_inv1 = false;	//true,false [Make image a negative?]
var CB_smth1 = false;	//true,false [Smooth image?]
var CB_gray1 = false;	//true,false [Make image grayscale?]
var CB_light1 = false;	//true,false [Lighten image?]
var CB_dark1 = false;	//true,false [Darken image?]
var CB_CF1 = false;		//true,false [Draw counting frame for 100X]

//COUNTING WORKFLOW

//Coansi  |  Step 2. Region for 10X stacks
var RB_draw1 = "lemon";		//"tangerine","blue","lemon","aqua","white","black" [Select a color with which to draw]
var CB_redraw1 = false;		//true,false [Re-draw the last region outline used]
var CB_redraw2 = false;		//true,false [Re-draw a region outline based on coordinates I supply]

//Coansi  |  Step 3. Sampling Fraction
var S_sf1 = 16;		//1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20 [Sampling Fraction]
var S_sf2 = 10;		//1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20 [Counting Frame Size]
var CB_cf1 = false;		//true,false [Use black/gray for the counting frame]
var CB_cf2 = false;		//true,false [Apply a random shade to the counting frame]
var CB_drawAfter = false;		//true,false [Prevent more than one counting frame appearing on the magnified sites]
var CB_label = false;		//true,false [Label the counting frames on the reference stack]
var CB_drawGrid = false;		//true,false [Draw the grid]
var CB_suppressCount = false;		//true,false [Suppress all messages]
var CB_regOutline = false;		//true,false [Save the location of the region outline so I can redraw it at a later date]

//Coansi  |  Markers
var RBG_m1 = "Marker 1    [aqua]";		//"Marker 1    [aqua]","Marker 2    [orange]","Marker 3    [pink]","Marker 4    [yellow]","Marker 5    [green]","Marker 6    [blue]","Marker 7    [red]","Marker 8    [white]","Marker 9    [black]"),"Marker 1    [aqua]" [Select a marker]

//SIZE MEASUREMENTS

//Coansi  |  Size Measurement Options
var RBG_szTech = "Point Estimator    (for irregular shapes)";		//"Point Estimator    (for irregular shapes)","Outline    (for irregular shapes)" [Select which probe you want to use for size measurement.]

//Coansi  |  Point Estimator
var S_peEst = 3;		//1,2,3,4,5 [Density of points]
var C_peCol = "RANDOM SELECTION";		//"RANDOM SELECTION","black","white","gray (dark)","gray (light)","blue (dark)","blue (bright)","blue (light)","turquoise","green (dark)","green (bright)","green (light)","yellow","orange (dark)","orange (light)","red (dark)","red (bright)","pink (dark)","pink (bright)","pink (light)","purple (dark)","purple (bright)","purple (light)" [Choose color for probe]
var CB_peZoom = false;		//true,false [Use zoom on individual profiles  [100X, 60X]]
var CB_pePic = false;		//true,false [Automatically take a snapshot when getting results]
var CB_peSupp = false;		//true,false [Suppress all messages]
var CB_peMon = false;		//true,false [Make a montage for reference]

//Coansi  |  Planimetry Size Measurement
var RBG_plaCol = "white";		//"aqua","black","blue","green","orange","pink","red","white","yellow" [Choose a color to draw with]
var CB_olZoom = false;		//true,false [Use zoom on individual profiles  [100X, 60X]]
var CB_olPic = false;		//true,false [Automatically take a snapshot when getting results]
var CB_olSupp = false;		//true,false [Suppress all messages]

//Help
var RBG_helpMenu = "General Problems";		//"Definitions","General Problems","Step 1. Stack Preparation","Step 2. Region Outline","Step 3. Sampling","Step 4. Markers","Step 5. Counting Frame Guidelines","Step 2. Size Measurements","Step 3. Markers","Known Bugs","About Coansi

//Coansi  |  Artistic effects
var RBG_effect1 = "none";		//"rainy window","pin art  (line plot)","ocean  (line plot)","EEG  (line plot)","puncta","princess","droplets","post-its","windshield","stucco","thermal  (flat)","fractal  (flat)","ghost  (flat)","layered mosaic  (slow)","80s rad  (slow)","mountains  (slow)","none" [Select an effect]

//Coansi  |  Stack statistics
var RBG_effect2 = "none";		//"average through z","maximum through z","minimum through z","sum through z  (cmk favorite)","penetrance graph","show profiles through z (z,y)","show profiles through z (x,z)","collapse stack","none" [Select a procedure]

//Close all
var CB_c1 = false;		//true,false [Close all zoomed windows]
var CB_c2 = false;		//true,false [Reset zoomed windows]
var CB_c3 = false;		//true,false [Close all image windows and z-stacks except the front window]
var CB_c4 = false;		//true,false [Close all text windows]
var CB_c5 = false;		//true,false [Close all image windows and z-stacks]


var sCmds = newMenu("Point Estimator Zoom Menu Tool",
	newArray("Step 1",
	"Step 2",
	"Step 3",
	"Step 4",
	"-",
	"Help"));


macro "Point Estimator Zoom Menu Tool - C090T0b12PT9b12E" {		//color#00ff33 tabx=0y=b font=12 print"p" 
	cmd = getArgument();
	if (cmd == "Step 1") {
		showMessage ("Coansi  |  Point Estimator","Place markers on the profiles you want to measure.\n \nThen click the orange number 2 on the toolbar.");
		setTool("multipoint");
	} 
	if (cmd == "Step 2") {
		peWindow = getTitle();
		Table.create("Coansi  |  Point Estimator locations");
		Table.showRowNumbers(true);
		selectWindow(peWindow);
		getSelectionCoordinates(x,y);
		for (h=0; h<x.length; h++) {
			Table.set("x", h, round(x[h]));
			Table.set("y", h, round(y[h]));
			//Table.set("z", h, round(z[h]));
			//Table.set("Marker", h, getValue("color.foreground"));
			Table.update;
		}
		selectWindow(peWindow);
		if (CB_peSupp == false) {
			showMessage("Coansi  |  Point Estimator","Draw a rectangle that encompasses the largest item you wish to measure.\nThen click the pink number 3 on the toolbar.");
		}
		setTool("rectangle");
	} 
	if (cmd == "Step 3") {
		peWindow = getTitle();
		//open zoomed
		if (selectionType != 0) {					//must have rectangle selection
			showMessage("ERROR Area not detected","The size for the largest object was not detected.\n \nDraw a rectangle around the largest profile you want to measure, \nthen click the pink number 3 on the toolbar.");
			setTool("rectangle");
			exit;
		}
		getSelectionBounds(x, y, width, height);
		widthR = parseInt(width + width/5);		//rectangle
		heightR = parseInt(height + height/5);			//rectangle
		tableCount = Table.size("Coansi  |  Point Estimator locations");
		for (g=0; g<tableCount; g++) {
			selectWindow("Coansi  |  Point Estimator locations");
			x = Table.getString("x", g);
			y = Table.getString("y", g);
			selectWindow(peWindow);
			xR = parseInt(parseInt(x)-widthR/2);
			yR = parseInt(parseInt(y)-heightR/2);
			widthC = minOf(getWidth(),getHeight())/100;			//circle
			heightC = widthC;									//circle 
			makeRectangle(xR, yR, widthR, heightR);
			run("Duplicate...", "duplicate");
			setLocation(screenWidth/4, screenHeight/5);
			run("Maximize");
			run("Out [-]");
			numG = g + 1;
			rename(numG + " of " + tableCount);
			selectWindow(peWindow);
			makeOval(x,y,widthC,heightC);
			run("Draw", "stack");
		}
		//arrange windows directly stacked with 1 at the front
		//selectWindow(info);
		openN2 = 2;
		while (openN2 > 1) {
			open1 = getTitle();
			openEnd = indexOf(open1,"o")-1;
			openStart = indexOf(open1,"f")+2;
			openLen =  lengthOf(open1);
			openN = parseInt(substring(open1,0,openEnd));
			openi = parseInt(substring(open1,openStart,openLen));
			openN2 = openN-1;
			string = toLowerCase(openN2+" of "+openi);
			if (isOpen(string)) {
				selectWindow(string);
				continue;
			} else {
				break;
			}
		}
		
		setTool("multipoint");
	} 
	if (cmd == "Step 4") {
		showMessage("uncoded");
	}
}

macro "PE Step 2 Action Tool - Cf60T4f202" {		//color 255,102,0 #ff6600
	peWindow = getTitle();
	Table.create("Coansi  |  Point Estimator locations");
	Table.showRowNumbers(true);
	selectWindow(peWindow);
	getSelectionCoordinates(x,y);
	for (h=0; h<x.length; h++) {
		Table.set("x", h, round(x[h]));
		Table.set("y", h, round(y[h]));
		//Table.set("z", h, round(z[h]));
		//Table.set("Marker", h, getValue("color.foreground"));
		Table.update;
	}
	selectWindow(peWindow);
	if (CB_peSupp == false) {
		showMessage("Coansi  |  Point Estimator","Draw a rectangle that encompasses the largest item you wish to measure.\nThen click the pink number 3 on the toolbar.");
	}
	setTool("rectangle");
}

macro "PE Step 3 Action Tool - Cf0fT4f203" {		//color 255,0,255 #ff00ff
	peWindow = getTitle();
	//open zoomed
	if (selectionType != 0) {					//must have rectangle selection
		showMessage("ERROR Area not detected","The size for the largest object was not detected.\n \nDraw a rectangle around the largest profile you want to measure, \nthen click the pink number 3 on the toolbar.");
		setTool("rectangle");
		exit;
	}
	getSelectionBounds(x, y, width, height);
	widthR = parseInt(width + width/5);		//rectangle
	heightR = parseInt(height + height/5);			//rectangle
	tableCount = Table.size("Coansi  |  Point Estimator locations");
	for (g=0; g<tableCount; g++) {
		selectWindow("Coansi  |  Point Estimator locations");
		x = Table.getString("x", g);
		y = Table.getString("y", g);
		selectWindow(peWindow);
		xR = parseInt(parseInt(x)-widthR/2);
		yR = parseInt(parseInt(y)-heightR/2);
		widthC = minOf(getWidth(),getHeight())/100;			//circle
		heightC = widthC;									//circle 
		makeRectangle(xR, yR, widthR, heightR);
		run("Duplicate...", "duplicate");
		setLocation(screenWidth/4, screenHeight/5);
		run("Maximize");
		run("Out [-]");
		numG = g + 1;
		rename(numG + " of " + tableCount);
		selectWindow(peWindow);
		makeOval(x,y,widthC,heightC);
		run("Draw", "stack");
	}
	//arrange windows directly stacked with 1 at the front
	//selectWindow(info);
	openN2 = 2;
	while (openN2 > 1) {
		open1 = getTitle();
		openEnd = indexOf(open1,"o")-1;
		openStart = indexOf(open1,"f")+2;
		openLen =  lengthOf(open1);
		openN = parseInt(substring(open1,0,openEnd));
		openi = parseInt(substring(open1,openStart,openLen));
		openN2 = openN-1;
		string = toLowerCase(openN2+" of "+openi);
		if (isOpen(string)) {
			selectWindow(string);
			continue;
		} else {
			break;
		}
	}
	
	setTool("multipoint");
}

macro "PE Step 4 Action Tool - C099T4f204" {
	showMessage("uncoded");
}






//java macro
macro "imagePrep" {
	//help image prep
	helpImagePrep = "<html>"
		+"<h1>List of dialog box options for <font color=orange>Step 1. Stack Preparation...</h1>"
		+"<h4><font color=orange>Flatten dual channels</h4>"
		+"<font color=teal>Collapses two channels into one composite stack. This will not alter the z-axis (depth) or t-axis (time). <br><u>This option should only be performed once on a stack.</u>"
		+"<h4><font color=orange>Extract green channel only</h4>"
		+"<font color=teal>Splits a two-channel stack and only keeps channel 1 (called green in the menu based on frequency of use). <br><u>This option should only be performed once on a stack.</u>"
		+"<h4><font color=orange>Extract red channel only</h4>"
		+"<font color=teal>Splits a two-channel stack and only keeps channel 2 (called red in the menu based on frequency of use). <br><u>This option should only be performed once on a stack.</u>"
		+"<h4><font color=orange>Undo all</h4>"
		+"<font color=teal>Reverses all prior stack adjustments."
		+"<h4><font color=orange>None</h4>"
		+"<font color=teal>Does not alter the channel set-ups. This should be selected if you want to re-visit this menu to toggle any of the below options on and off."
		+"<h4><font color=orange>Make image a negative?</h4>"
		+"<font color=teal>This will invert the colors (dark colors become light and light colors become dark). <br>For example: yellow on a black background will become blue on a white background"
		+"<h4><font color=orange>Smooth image?</h4>"
		+"<font color=teal>Uses a 4X recursive correction/prediction algorithm to filter and \"smooth\" the stack by decreasing high gain noise and increasing discernibility of faint profiles. This filter computes Kalman Gain and predicts variance of the next image with each iteration. Runs the \"Kalman Stack Filter\" plugin written in java (with acquisition noise 0.05 and bias 0.80) written by Christopher Philip Mauer (c)2003."
		+"<h4><font color=orange>Lighten image?</h4>"
		+"<font color=teal>Increases luminosity of image in an adapted manner: Makes the bright more bright while leaving the darkest parts minimally touched. If you need to run this more than once, make sure \"None.\" on the above choices is selected."
		+"<h4><font color=orange>Darken image?</h4>"
		+"<font color=teal>Decreases luminosity of image in an adapted manner: Makes the darkest parts of the image darker, while leaving the lightest parts relatively untouched. If you need to run this more than once, make sure \"None.\" on the above choices is selected."
		+"<h4><font color=orange>Draw counting frame for 100X</h4>"
		+"<font color=teal>Draws a single counting frame that covers 70-71 % of the canvas."
		+"<br><br><font color=white>\<\<scroll up\>\>"
		
	Dialog.create("Coansi  |  Step 1. Stack Preparation");
	Dialog.addRadioButtonGroup("Stack Preparation for Stereology",newArray(
		"Flatten dual channels",
		"Extract green channel only",
		"Extract red channel only",
		"Undo flatten",
		"None"),5,1,RBG_img1);
	Dialog.addCheckbox("Make image a negative?", CB_inv1);
	Dialog.addCheckbox("Smooth image?", CB_smth1);
	//Dialog.addCheckbox("Make image grayscale?", CB_gray1);
	Dialog.addCheckbox("Lighten image?", CB_light1);
	Dialog.addCheckbox("Darken image?", CB_dark1);
	Dialog.addMessage("  ");
	Dialog.addCheckbox("Draw counting frame for 100X", CB_CF1);
	Dialog.addHelp(helpImagePrep);
	Dialog.show();
	
	img1 = Dialog.getRadioButton;
	inv1 = Dialog.getCheckbox;
	smth1 = Dialog.getCheckbox;
	//gray1 = Dialog.getCheckbox;
	light1 = Dialog.getCheckbox;
	dark1 = Dialog.getCheckbox;
	CF1 = Dialog.getCheckbox;
	
	
/*	dir = getInfo("image.directory");
	name = getInfo("window.title");
	gr = "C1-";
	re = "C2-";
	channel1 = indexOf(name,gr); 
	channel2 = indexOf(name,re);
	if (channel1 > -1 || channel2 > -1){
		name = substring(name, 3);
	}
	address = dir+"\\"+name;*/
	
	
	//dual
	if (img1 == "Flatten dual channels"){
		run("Make Composite");
		run("Flatten");
	}
	//green channel
	if (img1 == "Extract green channel only"){
		Stack.getDimensions(width, height, channels, slices, frames);
		if (channels >= 2) {
			getLocationAndSize(x, y, width, height);
			run("Split Channels");
			run("Close");					//closes red
			run("RGB Color");
			setLocation(x,y);
		} if (channels < 2) {
			showMessage("ERROR  |  No second channel detected","Only a single channel can be detected.");
			exit;
		}
	}
	//red channel
	if (img1 == "Extract red channel only"){
		Stack.getDimensions(width, height, channels, slices, frames);
		if (channels >= 2) {
			getLocationAndSize(x, y, width, height);
			run("Split Channels");
			run("Put Behind [tab]");		//brings green to front
			close();						//closes green
			run("RGB Color");
			setLocation(x,y);
		} if (channels < 2) {
			showMessage("ERROR  |  No second channel detected","Only a single channel can be detected.");
			exit;
		}
	}
/*	//revert
	if (img1 == "Undo all"){
		getLocationAndSize(x, y, width, height);
		close();
		open(address);
		setLocation(x,y);
	}*/
	//revert
	if (img1 == "Undo flatten"){
		run("Revert");					//only works on merged channels and prior to drawing interaction
		run("Revert");
		run("Revert");
	}
	//invert
	if (inv1 == true){
		run("Invert","stack");
	}
	//smooth
	if (smth1 == true) {
		run("Kalman Stack Filter", "acquisition_noise=0.05 bias=0.8");	//Christopher Philip Mauer (c)2003
	}
	//lighten
	if (light1 == true) {
		run("Brightness/Contrast...");
		setMinAndMax(0, 165);
		run("Apply LUT", "stack");
		selectWindow("B&C");
		run("Close");
	}
	//darken
	if (dark1 == true) {
		run("Brightness/Contrast...");
		setMinAndMax(90, 255);
		run("Apply LUT", "stack");
		selectWindow("B&C");
		run("Close");
	}
	
	
	if (CF1 == true){						//counting frame
		wAll = getWidth();
		hAll = getHeight();
		run("RGB Color");
		//green
		makeSelection("angle",newArray(wAll*0.08,wAll*0.92,wAll*0.92),newArray(hAll*0.08,hAll*0.08,hAll*0.92));
		run("Color Picker...");
		setForegroundColor(55, 255, 5);
		selectWindow("CP");
		run("Close");
		run("Line Width...", "line=5");
		run("Draw", "stack");
		//red
		makeSelection("angle",newArray(wAll*0.08,wAll*0.08,wAll*0.92),newArray(hAll*0,hAll*0.92,hAll*0.92));
		run("Color Picker...");
		setForegroundColor(255, 5, 55);
		selectWindow("CP");
		run("Close");
		run("Line Width...", "line=5");
		run("Draw", "stack");
		makeSelection("angle",newArray(wAll*0.92,wAll*0.92,wAll*0.92),newArray(hAll*0.92,hAll*0.92,hAll*1));
		run("Draw", "stack");
		//markers
		run("Select None");
		setTool("multipoint");
		run("Point Tool...", "type=Circle color=Cyan size=[Extra Large] label show counter=0");
	}
}

//macro java
macro "selectRegion" {
	//help region outline
	helpRegionOutline = "<html>"
		+"<h1><font color=fuchsia>Step 2. Region Outline</h1>"
		+"<b><font color=fuchsia>1. </b><font color=gray> You must draw an outline around your region to confine the counting to a specific territory. This is done both for speed and accuracy.<br><br>"
		+"<b><font color=fuchsia>2. </b><font color=gray> The area (in square micrometers) for the outline will automatically be calculated when you move to <font color=fuchsia>Step 3.<br><br>"
		+"<b><font color=fuchsia>3. </b><font color=gray> Clicking <font color=fuchsia> OK<font color=gray> on this box will duplicate the stack and name the duplicate <font color=fuchsia>reference<font color=gray>.<br><b><u>Importantly, many future operations rely on this new stack named reference and the metainformation associated with it.</u></b><font color=gray> If you close the stack or alter the name and/or metainformation, you may recieve error messages later in the process.<br><br>"
		+"<b><font color=fuchsia>4. </b><font color=gray> The color for the region outline should be selected based on visibility.<br><br>"
		+"<b><font color=fuchsia>5. </b><font color=gray> How you define the region outline is up to you. Initially you will rely heavily on an atlas. As you count, you may find your definition changes. The important principle is consistency. <br><i>For example: If you notice you are going an inch (on your computer moniter) outside of a densely fibered territory on some subjects because there are neurons there, then consistently draw the region an inch around this densely fibered territory on all subjects.</i><br><br>"
		+"<br><hr><br><h2><font color=black>Usage:</h2>"
		+"1.  <u>Left-click</u> on a location at the region perimeter to start the outline (fully release the mouse button). <br><i>You will see a dot placed.</i><br><br>"
		+"2.  Move the mouse to another place along the region perimeter and <u>left-click</u> to place another dot. <br><i>You will see a line from the first dot to the second.</i><br><br>"
		+"3.  Continue to place dots as in Step 2.<br><i>You will see a line from the previous dot placed to where the mouse pointer is, as you move the mouse.</i><br><br>"
		+"4.  To end the region outline, you can connect the final dot to the first by <u>left-clicking</u> on the first dot. Alternately, you can <u>right-click</u> at any time to end the region outline.<br><i>You will see a completed polygon.</i><br><br>"
		+"•  After the region outline is completed, if you <u>left-click</u> somewhere outside the polygon you may experience it disappearing. If this happens you can try holding down <u>Ctrl + Shift and pressing 'E'</u>. If this does not bring the polygon back, you will have to re-draw it."
		+"<br><br><font color=white>\<\<scroll up\>\>"	
	
	Dialog.create("Coansi  |  Step 2. Region for 10X stacks");
	Dialog.setInsets(10,5,-10);
	Dialog.addMessage("You must first draw a line around the region you wish to examine.\n");
	Dialog.setInsets(10,5,-10);
	Dialog.addRadioButtonGroup("Select a color with which to draw:\n",newArray(
		"tangerine",
		"blue",
		"lemon",
		"aqua",
		"white",
		"black"),2,3,RB_draw1);
	Dialog.addMessage("");
	Dialog.setInsets(-5,0,0);
	Dialog.addMessage("Advanced options");
	Dialog.addCheckbox("Re-draw the last region outline used",CB_redraw1);
	Dialog.addCheckbox("Re-draw a region outline based on coordinates I supply",CB_redraw2);
	Dialog.addHelp(helpRegionOutline);
	Dialog.show();
	
	setTool("polygon");

	draw1 = Dialog.getRadioButton();
	stacktitle = getTitle();
	redraw1 = Dialog.getCheckbox();
	redraw2 = Dialog.getCheckbox();
	
	if (draw1 == "tangerine") {					//tangerine
		run("Select None");
		run("Duplicate...", "duplicate");
		setMetadata("Label","Original stack:  "+stacktitle);
		setLocation(screenWidth/2, screenHeight/7);
		rename("reference");
		run("Colors...", "foreground=black background=white selection=orange");
		setTool("polygon");
	}
		if (draw1 == "blue") {					//blue
		run("Select None");
		run("Duplicate...", "duplicate");
		setMetadata("Label","Original stack:  "+stacktitle);
		setLocation(screenWidth/2, screenHeight/7);
		rename("reference");
		run("Colors...", "foreground=black background=white selection=blue");
		setTool("polygon");
	}
		if (draw1 == "lemon") {					//lemon
		run("Select None");
		run("Duplicate...", "duplicate");
		setMetadata("Label","Original stack:  "+stacktitle);
		setLocation(screenWidth/2, screenHeight/7);
		rename("reference");
		run("Colors...", "foreground=black background=white selection=yellow");
		setTool("polygon");
	}
		if (draw1 == "aqua") {					//aqua
		run("Select None");
		run("Duplicate...", "duplicate");
		setMetadata("Label","Original stack:  "+stacktitle);
		setLocation(screenWidth/2, screenHeight/7);
		rename("reference");
		run("Colors...", "foreground=black background=white selection=cyan");
		setTool("polygon");
	}
		if (draw1 == "white") {					//white
		run("Select None");
		run("Duplicate...", "duplicate");
		setMetadata("Label","Original stack:  "+stacktitle);
		setLocation(screenWidth/2, screenHeight/7);
		rename("reference");
		run("Colors...", "foreground=black background=white selection=white");
		setTool("polygon");
	}		
	if (draw1 == "black") {						//black
		run("Select None");
		run("Duplicate...", "duplicate");
		setMetadata("Label","Original stack:  "+stacktitle);
		setLocation(screenWidth/2, screenHeight/7);
		rename("reference");
		run("Colors...", "foreground=black background=white selection=black");
		setTool("polygon");
	}
	
	//redraw
	if (redraw1 == true) {
		logGet = getInfo("log");
		indexMak = lastIndexOf(logGet,"makePoly");
		if(indexMak > 0) {
			indexEnd = indexOf(logGet,");",indexMak)+2;
			makePoly1 = substring(logGet,indexMak,indexEnd);
			showText("Select RUN MACRO from the MACROS menu",makePoly1);
		} else {
			showMessage("ERROR","No recorded outline found.");
		}
		exit;
	}
	if (redraw2 == true) {
		makePoly2 = getString("Enter the string of coordinates in the format demonstrated: ","473,288,452,362,450,405,453,485,485,532,502,538,537,532,546,484,569,432,586,385,573,346,566,321,533,273,501,270");
		showText("Select RUN MACRO from the MACROS menu","makePolygon("+makePoly2+");");
		if(isOpen("Select RUN MACRO from the MACROS menu")) {
			selectWindow("Select RUN MACRO from the MACROS menu");
		}
	}

}



//green			CF
macro "green" {
	run("Color Picker...");
	setForegroundColor(55, 255, 5);
	selectWindow("CP");
	run("Close");
	run("Line Width...", "line=2");
	run("Draw", "stack");
}
//red			CF
macro "red" {
	run("Color Picker...");
	setForegroundColor(255, 5, 55);
	selectWindow("CP");
	run("Close");
	run("Line Width...", "line=2");
	run("Draw", "stack");
}
//gray (green)	CF
macro "gray" {
	run("Color Picker...");
	setForegroundColor(155, 155, 155);
	selectWindow("CP");
	run("Close");
	run("Line Width...", "line=1");
	run("Draw", "stack");
}
//black (red)	CF
macro "black" {
	run("Color Picker...");
	setForegroundColor(55, 55, 55);
	selectWindow("CP");
	run("Close");
	run("Line Width...", "line=3");
	run("Draw", "stack");
}
//random green 	CF
macro "randomGreen" {
	ranGRred = random()*255;
	ranGRgre = random()*255+50;
	ranGRblu = random()*255;
	while (ranGRred > ranGRgre) {
		ranGRred = ranGRred - 50;
		ranGRgre = ranGRgre + 50;
	};
	run("Color Picker...");
	setForegroundColor(ranGRred,ranGRgre,ranGRblu);
	selectWindow("CP");
	run("Close");
	run("Line Width...", "line=2");
	run("Draw", "stack");
}
//random red	CF
macro "randomRed" {
	ranREred = random()*255+50;
	ranREgre = random()*105;
	ranREblu = random()*255;
	while (ranREgre > ranREred) {
		ranREgre = ranREgre - 50;
		ranREred = ranREred + 50;
	};
	run("Color Picker...");
	setForegroundColor(ranREred,ranREgre,ranREblu);
	selectWindow("CP");
	run("Close");
	run("Line Width...", "line=2");
	run("Draw", "stack");
}
//random gray	CF
macro "randomGray" {
	gray1 = random*155+55;
	run("Color Picker...");
	setForegroundColor(gray1,gray1,gray1);
	selectWindow("CP");
	run("Close");
	run("Line Width...", "line=1");
	run("Draw", "stack");
}
//random black	CF
macro "randomBlack" {
	black1 = random*55+5;
	run("Color Picker...");
	setForegroundColor(black1,black1,black1);
	selectWindow("CP");
	run("Close");
	run("Line Width...", "line=3");
	run("Draw", "stack");
}
//duplicate		CF
macro "duplicateMacro" {
	run("Select None");
	run("Duplicate...", "duplicate");
	setLocation(screenWidth/4, screenHeight/5);
}
//counting		CF
macro "counting" {
	run("Crop");
	wait(150);
	run("Maximize");
	zoom = floor(getZoom());
	if (zoom >= 3) {
		run("View 100%");
		run("In [+]");
		run("In [+]");
		run("In [+]");
	} if (zoom >= 2 && zoom < 3) {
		run("View 100%");
		run("In [+]");
		run("In [+]");
	} if (zoom >= 1 && zoom < 2) {
		run("View 100%");
	} if (zoom <1) {
		run("Maximize");
	}
	iter = 0;
	getDisplayedArea(x, y, width, height);
	while ((width < getWidth() || height < getHeight()) && iter < 3) {
		wait(150);
		run("Maximize");
		zoom = floor(getZoom());
		if (zoom >= 3) {
			run("View 100%");
			run("In [+]");
			run("In [+]");
			run("In [+]");
		} if (zoom >= 2 && zoom < 3) {
			run("View 100%");
			run("In [+]");
			run("In [+]");
		} if (zoom >= 1 && zoom < 2) {
			run("View 100%");
		} if (zoom <1) {
			run("Maximize");
		}
		iter++;
	}
	setLocation(screenWidth/4, screenHeight/5);
}
//java macro	CF    counting frame and sampling
macro "sampling" {
	//html sampling fraction
	helpSamplingFraction = "<html>"
		+"<h1><font color=#dc143c>Step 3 Sampling</h1>"
		+"<h4><font color=#dc143c>Sampling Fraction</h4>"
		+"<font color=black>This will set a fraction of the region to be counted. Below is a table that shows conversions from the selection values on the slider to percentage of area counted."
		+"<br><blockquote><font color=black>The sampling fraction represents the percentage of area covered by the <b><font color=blue>counting frame</b> <font color=black>(<b><font color=blue>blue</b> <font color=black>area in the diagram) within an unseen <b>grid</b> (<b>black</b> lines in the diagram) (See \"Help > Definitions\" for more information."
		+"<br><font color=white>````<font color=black>|<font color=white>````````````````````` <font color=black>|<font color=white>```"
		+"<br><font color=black> _ _ _|<font color=blue>______ <font color=black>_ _ _ _ _ _ _ _ _ _ |<font color=blue>__"
		+"<br><font color=white>````<font color=blue>|CFCFCF|<font color=white>```````````````<font color=blue>|CF"
		+"<br><font color=white>````<font color=blue>|CFCFCF|<font color=white>```````````````<font color=blue>|CF"
		+"<br><font color=white>````<font color=blue>|CFCFCF|<font color=white>```````````````<font color=blue>|CF"
		+"<br><font color=white>````<font color=blue>|______|<font color=white>```````````````<font color=blue>|__"
		+"<br><font color=white>````<font color=black>|<font color=white>````````````````````` <font color=black>|<font color=white>```"	
		+"<br><font color=white>````<font color=black>|<font color=white>````````````````````` <font color=black>|<font color=white>```"
		+"<br><font color=white>````<font color=black>|<font color=white>````````````````````` <font color=black>|<font color=white>```"
		+"<br><font color=white>````<font color=black>|<font color=white>````````````````````` <font color=black>|<font color=white>```"
		+"<br><font color=black> _ _ _|<font color=blue>______ <font color=black>_ _ _ _ _ _ _ _ _ _ |<font color=blue>__"
		+"<br><font color=white>````<font color=blue>|CFCFCF|<font color=white>```````````````<font color=blue>|CF"
		+"<br><font color=white>````<font color=blue>|CFCFCF|<font color=white>```````````````<font color=blue>|CF</blockquote>"
		+"<h4><font color=#dc143c>Counting Frame Size</h4>"
		+"<font color=black>A general rule for the <font color=#daa520>counting frame<font color=black> size is <font color=#daa520>10 ×<font color=black> the largest examples of the profile you are interested in counting. However, if the territory you are counting within is not densely populated, you may decide a larger <font color=#daa520>counting frame<font color=black> is desirable."
		+"<h4><font color=#dc143c>Use black/gray for the counting frame</h4>"
		+"<font color=black>Changes the default red/green <font color=#daa520>counting frame<font color=black> to a grayscale where the exclusion lines are thicker + darker and the inclusion lines are thinner + lighter."
		+"<h4><font color=#dc143c>Apply a random shade to the counting frame</h4>"
		+"<font color=black>Adjusts the red/green or black/gray <font color=#daa520>counting frame<font color=black> to random shades along the respective color scale. Prevents eye fatigue and helps distinguish different loci. If you are using the highest two sampling fractions, you may find it helpful to apply a random shade.<br><br>"
		+"<br><br><font color=white>\<\<scroll up\>\>"
		+"<br><hr><br><h2><font color=black>Sampling Fractions Table</h2>"
		+"<table>"
			+"<tr><th><u><font color=black>Selection number</u></th>"
				+"<th><u><font color=blue>Percent sampled</u></th>"
				+"<th><u><font color=green>Multiplication fraction</u></th></tr>"
			+"<tr><td>20</td> <td><font color=blue>100.0 %</td><td><font color=green>× 1/1</td></tr>"
			+"<tr><td>19</td> <td><font color=blue>66.7 %</td><td><font color=green>× 3/2</td></tr>"
			+"<tr><td>18</td> <td><font color=blue>50.0 %</td><td><font color=green>× 2/1</td></tr>"
			+"<tr><td>17</td> <td><font color=blue>41.5 %</td><td><font color=green>× 200/83</td></tr>"
			+"<tr><td>16</td> <td><font color=blue>33.3 %</td><td><font color=green>× 3/1</td></tr>"
			+"<tr><td>15</td> <td><font color=blue>25.0 %</td><td><font color=green>× 4/1</td></tr>"		
			+"<tr><td>14</td> <td><font color=blue>20.0 %</td><td><font color=green>× 5/1</td></tr>"
			+"<tr><td>13</td> <td><font color=blue>17.0 %</td><td><font color=green>× 100/17</td></tr>"	
			+"<tr><td>12</td> <td><font color=blue>15.0 %</td><td><font color=green>× 20/3</td></tr>"
			+"<tr><td>11</td> <td><font color=blue>13.0 %</td><td><font color=green>× 100/13</td></tr>"
			+"<tr><td>10</td> <td><font color=blue>11.5 %</td><td><font color=green>× 200/23</td></tr>"
			+"<tr><td>9</td> <td><font color=blue>10.0 %</td><td><font color=green>× 10/1</td></tr>"		
			+"<tr><td>8</td> <td><font color=blue>9.0 %</td><td><font color=green>× 100/9</td></tr>"
			+"<tr><td>7</td> <td><font color=blue>8.3 %</td><td><font color=green>× 12/1</td></tr>"
			+"<tr><td>6</td> <td><font color=blue>7.7 %</td><td><font color=green>× 13/1</td></tr>"
			+"<tr><td>5</td> <td><font color=blue>7.0 %</td><td><font color=green>× 100/7</td></tr>"
			+"<tr><td>4</td> <td><font color=blue>6.7 %</td><td><font color=green>× 15/1</td></tr>"
			+"<tr><td>3</td> <td><font color=blue>6.0 %</td><td><font color=green>× 50/3</td></tr>"		
			+"<tr><td>2</td> <td><font color=blue>5.6 %</td><td><font color=green>× 18/1</td></tr>"
			+"<tr><td>1</td> <td><font color=blue>5.0 %</td><td><font color=green>× 20/1</td></tr>"
		+"</table>"
		+"<br><br><font color=white>\<\<scroll up\>\>"

	
	wAll = getWidth();						//in pixels
	hAll = getHeight();						//in pixels


	//check that region outline was used
	if (getTitle() != "reference" || selectionType() == -1) {
		showMessage("ERROR No Region Detected","You must first draw an outline around your region\n using the right-click menu option \"Region Outline...\"");
		exit;
	}

	//print region outline location to log
	isCoansi = selectionType == 2;				//polygon only
	getSelectionCoordinates(x,y);
	regionUser = "(";
	for (h = 0; h < x.length; h++) {
		regionUser = regionUser+x[h]+","+y[h];
		if (h < x.length-1) {
			regionUser = regionUser+",";
		} if (h == x.length-1) {
			regionUser = regionUser+");";
		}
	}

	//region area
	run("Set Measurements...", "area redirect=None decimal=3");
	run("Measure");
	regionarea = getResult("Area");				//in microns
	selectWindow("Results");
	run("Close");
	print("\n",getMetadata("Label"),"\n Area:",regionarea,getInfo("micrometer.abbreviation"),"^2");
	//region is drawn, clear outside
	run("Colors...", "foreground=white background=black selection=yellow");
	run("Clear Outside", "stack");


	//dialog box
	while (true) {
		Dialog.create("Coansi  |  Step 3. Sampling Fraction");
		Dialog.addSlider("Sampling Fraction:",1,20,S_sf1);
		Dialog.setInsets(-5,0,0);
		Dialog.addMessage("small fraction of region sampled = [1]            whole region sampled =[20]");
		Dialog.addMessage("");
		Dialog.addSlider("Counting Frame Size:",1,20,S_sf2);
		Dialog.setInsets(-5,120,0);
		Dialog.addMessage("small = [1]            large = [20]");
		Dialog.addCheckbox("Use black/gray for the counting frame",CB_cf1);
		Dialog.addCheckbox("Apply a random shade to the counting frame",CB_cf2);
		Dialog.addMessage("");
		Dialog.setInsets(-5,0,0);
		Dialog.addMessage("Advanced options");
		//Dialog.addCheckbox("Prevent more than one counting frame appearing on the magnified sites",CB_drawAfter);
		Dialog.addCheckbox("Label the counting frames on the reference stack",CB_label);
		Dialog.addCheckbox("Draw the grid",CB_drawGrid);
		Dialog.addCheckbox("Suppress all messages",CB_suppressCount);
		Dialog.setInsets(-5,50,0);
		Dialog.addMessage("Only select this if you know what you are doing in Coansi. You must not \nclick anywhere until the next process is complete. This option will \nsuppress that and other notifications for the counting process.");
		Dialog.addCheckbox("Save the location of the region outline so I can redraw it at a later date",CB_regOutline);
		Dialog.addHelp(helpSamplingFraction);
		Dialog.show();
		
		sf1 = round(Dialog.getNumber);			//sampling fraction
		sf2 = round(Dialog.getNumber);			//cf size
		cf1 = Dialog.getCheckbox;				//gray cf
		cf2 = Dialog.getCheckbox;				//random color cf
		//drawAfter = Dialog.getCheckbox;			//if SF > 14
		label = Dialog.getCheckbox;				//label CF on reference with numbers of zoom windows
		drawGrid = Dialog.getCheckbox;			//draw grid on reference stack
		suppressCount = Dialog.getCheckbox;			//suppresses all pop-ups
		regOutline = Dialog.getCheckbox;		//prints x,y of outline to Log
		
		i = 0;									//instances of CF drawn
		n = 1;									//for pop-out windows
		linewidth = 2;							//refer to line width in draw macros
		sfinterval = 0;							//variable for number of CF total
		CF = abs((21-sf2)+1);					//takes the scale and reverses order for formula use
		w = wAll/(CF*CF);						//in pixels
		h = hAll/(CF*CF);
		ranthrowX = random()*CF*w;				//x offset CF
		ranthrowY = random()*CF*h;				//y offset CF
		variable = 1;							//defined later based on sf1

		
		if (sf1 > 20 || sf1 < 1 || sf2 > 20 || sf2 < 1) {
			showMessage("ERROR","You must choose a whole number between [1] and [20] for the \"Sampling Fraction,\"\n and a whole number between [1] and [20] for the \"Counting Frame Size.\"");
			continue;
		}
		break;
	}
		
		
	//print sampling fraction
	print("Sampling fraction: ",sf1,"  units");
	
	//print region outline
	if (regOutline == true) {
		if (isCoansi == 1) {				//1 == true
			print("\nRegion outline:\nmakePolygon"+regionUser,"\n  |-----------------------------------------------------------------------------------------------------|\n    [To redraw the outline, use \"Step 2. Region Outline\" from the right-click menu.]\n  |-----------------------------------------------------------------------------------------------------|\n");
		} else {
			print("\nRegion outline:  ERROR\nThis operation only works with the polygon selection (accessed through Step 2: Region Outline...).\n");
		}
	}
	
	
	//SWITCH WONT WORK WITH MACRO SCRIPTS
	
	if (sf1 == 20) {					//20 count/"i"|sampling| 100% (1 / 1)				1.000
		variable = 1;
	} if (sf1 == 19) {					//19 count/"i" 67% (1 / 1.5)			0.6667
		variable = 1.5;
	} if (sf1 == 18) {					//18 count/"i" 50% (1 / 2)				0.5000
		variable = 2;
	} if (sf1 == 17) {					//17 count/"i" 42% (1 / 2.4)			0.4150
		variable = 1/0.415;
	} if (sf1 == 16) {					//16 count/"i" 33% (1 / 3)				0.3333
		variable = 3;
	} if (sf1 == 15) {					//15 count/"i" 25% (1 / 4)				0.2500
		variable = 4;
	} if (sf1 == 14) {					//14 count/"i" 20% (1 / 5)				0.2000
		variable = 5;
	} if (sf1 == 13) {					//13 count/"i" 17% (1 / 5.9)			0.1700
		variable = 1/0.17;
	} if (sf1 == 12) {					//12 count/"i" 15% (1 / 6.7)			0.1500
		variable = 1/0.15;
	} if (sf1 == 11) {					//11 count/"i" 13% (1 / 7.7)			0.1300
		variable = 1/0.13;
	} if (sf1 == 10) {					//10 count/"i" 12% (1 / 8.7)			0.1150
		variable = 1/0.115;
	} if (sf1 == 9) {					//9 count/"i" 10% (1 / 10)				0.1000
		variable = 10;
	} if (sf1 == 8) {					//8 count/"i" 9% (1 / 11.1)				0.09000
		variable = 1/0.09;
	} if (sf1 == 7) {					//7 count/"i" 8% (1 / 12)				0.08333
		variable = 12;
	} if (sf1 == 6) {					//6 count/"i" 8% (1 / 13)				0.07692
		variable = 13;
	} if (sf1 == 5) {					//5 count/"i" 7% (1 / 14.3)				0.07000
		variable = 1/0.07;
	} if (sf1 == 4) {					//4 count/"i" 7% (1 / 15)				0.06667
		variable = 15;
	} if (sf1 == 3) {					//3 count/"i" 6% (1 / 16.7)				0.06000
		variable = 1/0.06;
	} if (sf1 == 2) {					//2 count/"i" 6% (1 / 18)				0.05556
		variable = 18;
	} if (sf1 == 1) {					//1 count/"i" 5% (1 / 20)				0.05000
		variable = 20;
	}
	
	
	grid = sqrt(CF*w*CF*h*variable);
	gridx = grid/h;				//width
	gridy = grid/w;				//height


	//count/"i"
	for (yy = -1; yy <= CF; yy++) {
		for (xx = -1; xx <= CF; xx++) {
			a = (xx*gridx)*w+ranthrowX;				//columns (x axis move)
			b = (yy*gridy)*h+ranthrowY;				//rows (y axis move)
			makeRectangle(a+linewidth,b+linewidth,(CF*w)-linewidth*2,(CF*h)-linewidth*2);
			getStatistics(area, mean, min, max, std, histogram);
			if (round(mean)>0) {
				i++;
			}
		}
	}

	//warning when opening many stacks
	if (suppressCount == false) {
		if (i >= 50) {
			if (i > 100) {
				yy1 = getBoolean("This parameter will open over 100 windows. \nPress \"Yes\" to proceed or \"No\" to select a different parameter.");
				if (yy1 == 0) {
					run("Restore Selection");
					exit;
				}
			}	if (i >= 50 && i <=100) {
				yy2 = getBoolean("This parameter will open between 50 and 100 windows. \nPress \"Yes\" to proceed or \"No\" to select a different parameter.");
				if (yy2 == 0) {
					run("Restore Selection");
					exit;
				}
			}
		}
	}
	
	//color for grid and numbering
	selectWindow("reference");
	run("Select All");
	getStatistics(area, mean, min, max, std, histogram);
	colorX = 255-mean;
	fontSz = round(hAll/50);			//font for writing CF numbers on reference

	//sampling
	for (yy = -1; yy <= CF; yy++) {
		for (xx = -1; xx <= CF; xx++) {
			a = (xx*gridx)*w+ranthrowX;				//columns (x axis move)
			b = (yy*gridy)*h+ranthrowY;				//rows (y axis move)
			makeRectangle(a+linewidth,b+linewidth,(CF*w)-linewidth*2,(CF*h)-linewidth*2);
			getStatistics(area, mean, min, max, std, histogram);
			if (round(mean)>0) {
				makeSelection("angle",newArray(a,a+CF*w,a+CF*w),newArray(b,b,b+CF*h));
				if (cf1 == false && cf2 == false) {
					run("green");
				} if (cf1 == false && cf2 == true) {
					run("randomGreen");
				} if (cf1 == true && cf2 == false) {
					run("gray");
				} if (cf1 == true && cf2 == true) {
					run("randomGray");
				} 
				makeSelection("angle",newArray(a,a,a+CF*w),newArray(b-(CF/2-0.5)*h,b+CF*h,b+CF*h));
				if (cf1 == false && cf2 == false) {
					run("red");
				} if (cf1 == false && cf2 == true) {
					run("randomRed");
				} if (cf1 == true && cf2 == false) {
					run("black");
				} if (cf1 == true && cf2 == true) {
					run("randomBlack");
				}
				makeSelection("angle",newArray(a+CF*w,a+CF*w,a+CF*w),newArray(b+CF*h,b+CF*h,b+CF*h+(CF/2-0.5)*h));
				run("Draw", "stack");
			}
		}
	}

	//startCounting
	for (yy = -1; yy <= CF; yy++) {
		for (xx = -1; xx <= CF; xx++) {
			a = (xx*gridx)*w+ranthrowX;				//columns (x axis move)
			b = (yy*gridy)*h+ranthrowY;				//rows (y axis move)
			metax = a-(CF*w)*0.8;	//metainfo x, where box starts x axis
			if (metax < 0) {		//reset to a 0 for zoom if drawn with negative start on "reference"
				metax = 0;
			}
			metay = b-(CF*h)*0.8;	//metainfo y, where box starts y axis
			if (metay < 0) {		//reset to a 0 start on zoom if drawn with negative start on "reference"
				metay = 0;
			}
			makeRectangle(a+linewidth,b+linewidth,(CF*w)-linewidth*2,(CF*h)-linewidth*2);
			getStatistics(area, mean, min, max, std, histogram);
			if (round(mean)>0) {
				run("duplicateMacro");
				rename(n + " of " + i);
				makeRectangle(a-(CF*w)*0.8,b-(CF*h)*0.8,CF*w*2.6,CF*h*2.6);
				run("counting");
				info = getTitle();
				setMetadata("Info", info+"    x"+metax+"    y"+metay);
				selectWindow("reference");
				//label CF on reference
				if (label == true) {			
					setForegroundColor(colorX,colorX,colorX);
					setFont("Monospaced", fontSz);
					xLabel = a+2;
					yLabel = b-fontSz-2;
					if (xLabel < 0 + 2) {					//origin + CF line width
						xLabel = a+CF*w;
					} if (yLabel < 0 - 2-fontSz) {					//origin + line width
						yLabel = b+CF*h;
					}
					makeText(n,xLabel,yLabel);
					run("Draw", "stack");
				}
				n++;
			}
		}
	}

	
	//arrange windows directly stacked with 1 at the front
	selectWindow(info);
	openN2 = 2;
	while (openN2 > 1) {
		open1 = getTitle();
		openEnd = indexOf(open1,"o")-1;
		openStart = indexOf(open1,"f")+2;
		openLen =  lengthOf(open1);
		openN = parseInt(substring(open1,0,openEnd));
		openi = parseInt(substring(open1,openStart,openLen));
		openN2 = openN-1;
		string = toLowerCase(openN2+" of "+openi);
		if (isOpen(string)) {
			selectWindow(string);
			continue;
		} else {
			break;
		}
	}
	
	//draw grid
	if (drawGrid == true) {				
		selectWindow("reference");
		for (k = 0; k < wAll || k < hAll; k+=grid) {
			setForegroundColor(colorX,colorX,colorX);
			run("Line Width...", "line=.5");
			makeLine(ranthrowX+k,0,ranthrowX+k,hAll);
			run("Draw", "stack");
			makeLine(0,ranthrowY+k,wAll,ranthrowY+k);
			run("Draw", "stack");
		}
		run("Select None");
	}
	
	//markers
	setTool("multipoint");
	run("Point Tool...", "type=Circle color=Cyan size=[Extra Large] label show counter=0");
	
	//message ok to begin
	if (suppressCount == false) {
		showMessage("Step 4. Counting profiles","You can start counting now. \n \n • Place markers on the zoomed-in stacks (labeled \"1 of 36\" etc.). \n • Use the \"Step 5. Next\" option from the right-click menu to progress.\n • If you want to use more than one marker, finish counting with one marker for a sampling section, \nthen select \"(Save Counts)\" from the right-click menu before choosing a new marker.\n • When you are finished with all sampling sections, select \"Step 6. Get Results\" from the right-click menu. \n \n DO NOT CLOSE THE \"reference\" OR \"Log\" WINDOWS.");
	}
}




//java macro
macro "markers" {
	Dialog.create("Coansi  |  Markers");
	Dialog.addRadioButtonGroup("Select a marker:", newArray(
		"Marker 1    [aqua]",
		"Marker 2    [orange]",
		"Marker 3    [pink]",
		"Marker 4    [yellow]",
		"Marker 5    [green]",
		"Marker 6    [blue]",
		"Marker 7    [red]",
		"Marker 8    [white]",
		"Marker 9    [black]"),
		9,1,RBG_m1);
	Dialog.show();
	
	m1 = Dialog.getRadioButton;
	
	//marker choices
	if (m1 == "Marker 1    [aqua]"){								//aqua(label) | cyan(source)
		setTool("multipoint");
		//run("Colors...", "foreground=black background=black selection=cyan");
		run("Point Tool...", "type=Circle color=Cyan size=[Extra Large] label show counter=0");
	} if (m1 == "Marker 2    [orange]"){							//orange(label) | orange(source)
		setTool("multipoint");
		//run("Colors...", "foreground=black background=black selection=orange");
		run("Point Tool...", "type=Dot color=Orange size=[Large] label show counter=0");
	} if (m1 == "Marker 3    [pink]"){								//pink(label) | magenta(source)
		setTool("multipoint");
		//run("Colors...", "foreground=black background=black selection=magenta");
		run("Point Tool...", "type=Crosshair color=Magenta size=[Medium] label show counter=0");
	} if (m1 == "Marker 4    [yellow]"){							//yellow(label) | yellow(source)
		setTool("multipoint");
		//run("Colors...", "foreground=black background=black selection=yellow");
		run("Point Tool...", "type=Circle color=Yellow size=[Extra Large] label show counter=0");
	} if (m1 == "Marker 5    [green]"){								//green(label) | green(source)
		setTool("multipoint");
		//run("Colors...", "foreground=black background=black selection=green");
		run("Point Tool...", "type=Dot color=Green size=[Large] label show counter=0");
	} if (m1 == "Marker 6    [blue]"){								//blue(label) | blue(source)
		setTool("multipoint");
		//run("Colors...", "foreground=black background=black selection=blue");
		run("Point Tool...", "type=Crosshair color=Blue size=[Medium]] label show counter=0");
	} if (m1 == "Marker 7    [red]"){								//red(label) | red(source)
		setTool("multipoint");
		//run("Colors...", "foreground=black background=black selection=red");
		run("Point Tool...", "type=Circle color=Red size=[Extra Large] label show counter=0");
	} if (m1 == "Marker 8    [white]"){								//white(label) | white(source)
		setTool("multipoint");
		//run("Colors...", "foreground=black background=black selection=white");
		run("Point Tool...", "type=Dot color=White size=[Large] label show counter=0");
	} if (m1 == "Marker 9    [black]"){								//black(label) | black(source)
		setTool("multipoint");
		//run("Colors...", "foreground=black background=black selection=black");
		run("Point Tool...", "type=Crosshair color=Black size=[Medium] label show counter=0");
	}
	setTool("multipoint");
}
	

	
//macro java
macro "next" {
	//select the next counting frame window
	open1 = getTitle();
	openEnd = indexOf(open1,"o")-1;
	openStart = indexOf(open1,"f")+2;
	openLen =  lengthOf(open1);
	openN = parseInt(substring(open1,0,openEnd));
	openi = parseInt(substring(open1,openStart,openLen));
	
	if (selectionType() != -1) {
		run("lockMarkers");
	}
	setOption("Changes", false);
	run("Close");
	wait(150);
	if (openN < openi) {
		openN2 = openN+1;
		string = toLowerCase(openN2+" of "+openi);
		selectWindow(string);
	}
}
//java macro
macro "lockMarkers" {
	if (isOpen("reference") == false) {
		showMessage("ERROR No Region Detected","You must first draw an outline around your region\n using the right-click menu option \"Region Outline...\"");
		exit;
	}
	//log
	if (selectionType() == -1) {
		colorlog1 = "(no color)";
		colorlog2 = "[nc]";
	} if (selectionType() != -1) {
		colorlog1 = Roi.getDefaultColor;			//getInfo("selection.color") does not work
		if (colorlog1 == "cyan"){
			colorlog1 = "(aqua)";
			colorlog2 = "[aq]";
		} if (colorlog1 == "#ffc800"){
			colorlog1 = "(orange)";
			colorlog2 = "[or]";
		} if (colorlog1 == "magenta"){
			colorlog1 = "(pink)";
			colorlog2 = "[pi]";
		} if (colorlog1 == "yellow"){
			colorlog1 = "(yellow)";
			colorlog2 = "[ye]";
		} if (colorlog1 == "green"){
			colorlog1 = "(green)";
			colorlog2 = "[gr]";
		} if (colorlog1 == "blue"){
			colorlog1 = "(blue)";
			colorlog2 = "[bu]";
		} if (colorlog1 == "red"){
			colorlog1 = "(red)";
			colorlog2 = "[re]";
		} if (colorlog1 == "white"){
			colorlog1 = "(white)";
			colorlog2 = "[wh]";
		} if (colorlog1 == "black"){
			colorlog1 = "(black)";
			colorlog2 = "[ba]";
		}
	}
	run("Set Measurements...", "display add redirect=None decimal=3");
	run("Measure");
	//synchronize
	if (selectionType() != -1) {
		//location on reference (in pixels)
		metainfo = getMetadata("Info");
		indexX = indexOf(metainfo,"x");
		indexY = indexOf(metainfo,"y");
		length = lengthOf(metainfo);
		locX = parseFloat(substring(metainfo, indexX+1, indexY));
		locY = parseFloat(substring(metainfo, indexY+1, length));
		//location on zoom (in pixels)
		current = getTitle();
		ncounts = nResults;
		row = 0;
		//conversion and draw
		while (ncounts > 0 && row <= (ncounts-1)) {
			//conversion
			getPixelSize(unit, pixelWidth, pixelHeight);
			conversionX = 1/pixelWidth;
			conversionY = 1/pixelHeight;
			ptx = getResult("X",row)*conversionX;
			pty = getResult("Y",row)*conversionY;
			//draw
			selectWindow("reference");
			Overlay.drawLabels(false);
			makePoint(ptx+locX,pty+locY);
			run("Add Selection...");
			run("Select None");
			selectWindow(current);
			showStatus("  PLEASE WAIT while markers are transfered...");
			row++;
		}
	}
	countMP = nResults;
	if(selectionType() == -1){
		countMP = 0;
	} for (r = 0; r <= nResults-1; r++){
		setResult("C5",r,countMP);
	}
	CFtitle = getTitle();
	c1 = getResult("C5");	
	if (c1 > 0) {
		c1;
	} else {
		c1 = 0;
	}
	getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
	hour1 = hour;
	if (hour > 12) {
		hour1 = hour - 12;
	} min = minute;
	if (min < 10) {
		min = "0" + min;
	} ampm = " a.m.";
	if (hour >= 12) {
		ampm = " p.m.";
	}
	close("Results");
	print("Location",colorlog2,CFtitle,"count:","  ",c1,"  ",colorlog1,"    ",hour1,":",min,ampm);
	if (selectionType() != -1) {
		run("Overlay Options...", "stroke=none width=0 fill=none set");
		run("Overlay Options...", "stroke=none width=0 fill=none");
		run("Add Selection...");
	}
}



//results calculations
macro "resultsCounts" {
	logGet = getInfo("log");
	indexArea = lastIndexOf(logGet,"Area: ")+6;
	indexMicro = indexOf(logGet,getInfo("micrometer.abbreviation"),indexArea);
	area1 = parseFloat(substring(logGet,indexArea,indexMicro));
	indexSF = lastIndexOf(logGet,"Sampling fraction: ")+19;
	indexUnits = lastIndexOf(logGet,"units");
	sampFrac = parseInt(substring(logGet,indexSF,indexUnits));
	if (sampFrac == 1) {
	sampFrac2 = 20/1;
	} if (sampFrac == 2) {
	sampFrac2 = 18/1;
	} if (sampFrac == 3) {
	sampFrac2 = 50/3;
	} if (sampFrac == 4) {
	sampFrac2 = 15/1;
	} if (sampFrac == 5) {
	sampFrac2 = 100/7;
	} if (sampFrac == 6) {
	sampFrac2 = 13/1;
	} if (sampFrac == 7) {
	sampFrac2 = 12/1;
	} if (sampFrac == 8) {
	sampFrac2 = 100/9;
	} if (sampFrac == 9) {
	sampFrac2 = 10/1;
	} if (sampFrac == 10) {
	sampFrac2 = 200/23;
	} if (sampFrac == 11) {
	sampFrac2 = 100/13;
	} if (sampFrac == 12) {
	sampFrac2 = 20/3;
	} if (sampFrac == 13) {
	sampFrac2 = 100/17;
	} if (sampFrac == 14) {
	sampFrac2 = 5/1;
	} if (sampFrac == 15) {
	sampFrac2 = 4/1;
	} if (sampFrac == 16) {
	sampFrac2 = 3/1;
	} if (sampFrac == 17) {
	sampFrac2 = 200/83;
	} if (sampFrac == 18) {
	sampFrac2 = 2/1;
	} if (sampFrac == 19) {
	sampFrac2 = 3/2;
	} if (sampFrac == 20) {
	sampFrac2 = 1/1;
	}

	indexCount1 = indexOf(logGet,"count",indexArea);
	indexF = indexOf(logGet," of ",indexArea);
	indexAqua = indexOf(logGet,"    (aqua",indexArea);			//1 aq
	indexOran = indexOf(logGet,"    (orange",indexArea);		//2 or
	indexPink = indexOf(logGet,"    (pink",indexArea);			//3 pi
	indexYell = indexOf(logGet,"    (yellow",indexArea);		//4 ye
	indexGree = indexOf(logGet,"    (green",indexArea);			//5 gr
	indexBlue = indexOf(logGet,"    (blue",indexArea);			//6 blu
	indexRed = indexOf(logGet,"    (red",indexArea);			//7 re
	indexWhit = indexOf(logGet,"    (white",indexArea);			//8 wh
	indexBlac = indexOf(logGet,"    (black",indexArea);			//9 bla
	nframe = 0;
	if (indexAqua >= 1 || indexOran >= 1 || indexPink >= 1 || indexYell >= 1 || indexGree >= 1 || indexBlue >= 1 || indexRed >= 1 || indexWhit >= 1 || indexBlac >= 1){
		nframe = substring(logGet,indexF+4,indexCount1 - 1);	//total sample sites #
	}


	print("______");
	//marker 1 aqua
	if (indexCount1 > 1 && indexAqua > 0) {								//1 aq
		subtotal = 0;
		for(ic = 1; ic <= nframe; ic++) {
			ic2 = "Location [aq] "+ic+" of";
			icc = "(aqua)";												//aqua
			indexIC = indexOf(logGet,ic2,indexMicro);	//if doesn't exist will give -1
			//if location n of i exists
			if (indexIC > 1) {	
				indexICc = indexOf(logGet,icc,indexIC);
				ICsubtract = parseInt(indexICc-indexIC);
				//if location and color are on the same line
				if (indexIC > 1 && ICsubtract > 0 && ICsubtract < 40) {
					indexCount = indexOf(logGet,"count:",indexIC);
					indexColor = indexOf(logGet,icc,indexIC);
					if (indexColor > 0) {
						subtotal += parseInt(substring(logGet,indexCount+7,indexColor));
					}
				}
			}
		}
		//print subtotal
		print("Subtotal for "+"Marker 1 "+icc+":    "+subtotal);		//print 1
		print("Calculated total for entire section: "+parseFloat(subtotal*sampFrac2));
		//calculated count
		mult1 = subtotal * sampFrac2;
		multReg = mult1/area1*100000;
		print(parseFloat(multReg),"profiles per 100,000",getInfo("micrometer.abbreviation"),"^2");
	}
	//marker 2 orange
	if (indexCount1 > 1 && indexOran > 0) {								//2 or
		subtotal = 0;
		for(ic = 1; ic <= nframe; ic++) {
			ic2 = "Location [or] "+ic+" of";
			icc = "(orange)";											//orange
			indexIC = indexOf(logGet,ic2,indexMicro);	//if doesn't exist will give -1
			//if location n of i exists
			if (indexIC > 1) {	
				indexICc = indexOf(logGet,icc,indexIC);
				ICsubtract = parseInt(indexICc-indexIC);
				//if location and color are on the same line
				if (indexIC > 1 && ICsubtract > 0 && ICsubtract < 40) {
					indexCount = indexOf(logGet,"count:",indexIC);
					indexColor = indexOf(logGet,icc,indexIC);
					if (indexColor > 0) {
						subtotal += parseInt(substring(logGet,indexCount+7,indexColor));
					}
				}
			}
		}
		//print subtotal
		print("Subtotal for "+"Marker 2 "+icc+":    "+subtotal);		//print 2
		print("Calculated total for entire section: "+parseFloat(subtotal*sampFrac2));
		//calculated count
		mult1 = subtotal * sampFrac2;
		multReg = mult1/area1*100000;
		print(parseFloat(multReg),"profiles per 100,000",getInfo("micrometer.abbreviation"),"^2");
	}  
	//marker 3 pink
	if (indexCount1 > 1 && indexPink > 0) {								//3 pi
		subtotal = 0;
		for(ic = 1; ic <= nframe; ic++) {
			ic2 = "Location [pi] "+ic+" of";
			icc = "(pink)";												//pink
			indexIC = indexOf(logGet,ic2,indexMicro);	//if doesn't exist will give -1
			//if location n of i exists
			if (indexIC > 1) {	
				indexICc = indexOf(logGet,icc,indexIC);
				ICsubtract = parseInt(indexICc-indexIC);
				//if location and color are on the same line
				if (indexIC > 1 && ICsubtract > 0 && ICsubtract < 40) {
					indexCount = indexOf(logGet,"count:",indexIC);
					indexColor = indexOf(logGet,icc,indexIC);
					if (indexColor > 0) {
						subtotal += parseInt(substring(logGet,indexCount+7,indexColor));
					}
				}
			}
		}
		//print subtotal
		print("Subtotal for "+"Marker 3 "+icc+":    "+subtotal);		//print 3
		print("Calculated total for entire section: "+parseFloat(subtotal*sampFrac2));
		//calculated count
		mult1 = subtotal * sampFrac2;
		multReg = mult1/area1*100000;
		print(parseFloat(multReg),"profiles per 100,000",getInfo("micrometer.abbreviation"),"^2");
	}  
	//marker 4 yellow
	if (indexCount1 > 1 && indexYell > 0) {								//4 ye
		subtotal = 0;
		for(ic = 1; ic <= nframe; ic++) {
			ic2 = "Location [ye] "+ic+" of";
			icc = "(yellow)";											//yellow
			indexIC = indexOf(logGet,ic2,indexMicro);	//if doesn't exist will give -1
			//if location n of i exists
			if (indexIC > 1) {	
				indexICc = indexOf(logGet,icc,indexIC);
				ICsubtract = parseInt(indexICc-indexIC);
				//if location and color are on the same line
				if (indexIC > 1 && ICsubtract > 0 && ICsubtract < 40) {
					indexCount = indexOf(logGet,"count:",indexIC);
					indexColor = indexOf(logGet,icc,indexIC);
					if (indexColor > 0) {
						subtotal += parseInt(substring(logGet,indexCount+7,indexColor));
					}
				}
			}
		}
		//print subtotal
		print("Subtotal for "+"Marker 4 "+icc+":    "+subtotal);		//print 4
		print("Calculated total for entire section: "+parseFloat(subtotal*sampFrac2));
		//calculated count
		mult1 = subtotal * sampFrac2;
		multReg = mult1/area1*100000;
		print(parseFloat(multReg),"profiles per 100,000",getInfo("micrometer.abbreviation"),"^2");
	}  
	//marker 5 green
	if (indexCount1 > 1 && indexGree > 0) {								//5 gr
		subtotal = 0;
		for(ic = 1; ic <= nframe; ic++) {
			ic2 = "Location [gr] "+ic+" of";
			icc = "(green)";											//green
			indexIC = indexOf(logGet,ic2,indexMicro);	//if doesn't exist will give -1
			//if location n of i exists
			if (indexIC > 1) {	
				indexICc = indexOf(logGet,icc,indexIC);
				ICsubtract = parseInt(indexICc-indexIC);
				//if location and color are on the same line
				if (indexIC > 1 && ICsubtract > 0 && ICsubtract < 40) {
					indexCount = indexOf(logGet,"count:",indexIC);
					indexColor = indexOf(logGet,icc,indexIC);
					if (indexColor > 0) {
						subtotal += parseInt(substring(logGet,indexCount+7,indexColor));
					}
				}
			}
		}
		//print subtotal
		print("Subtotal for "+"Marker 5 "+icc+":    "+subtotal);		//print 5
		print("Calculated total for entire section: "+parseFloat(subtotal*sampFrac2));
		//calculated count
		mult1 = subtotal * sampFrac2;
		multReg = mult1/area1*100000;
		print(parseFloat(multReg),"profiles per 100,000",getInfo("micrometer.abbreviation"),"^2");
	}   
	//marker 6 blue
	if (indexCount1 > 1 && indexBlue > 0) {								//6 blu
		subtotal = 0;
		for(ic = 1; ic <= nframe; ic++) {
			ic2 = "Location [bu] "+ic+" of";
			icc = "(blue)";												//blue
			indexIC = indexOf(logGet,ic2,indexMicro);	//if doesn't exist will give -1
			//if location n of i exists
			if (indexIC > 1) {	
				indexICc = indexOf(logGet,icc,indexIC);
				ICsubtract = parseInt(indexICc-indexIC);
				//if location and color are on the same line
				if (indexIC > 1 && ICsubtract > 0 && ICsubtract < 40) {
					indexCount = indexOf(logGet,"count:",indexIC);
					indexColor = indexOf(logGet,icc,indexIC);
					if (indexColor > 0) {
						subtotal += parseInt(substring(logGet,indexCount+7,indexColor));
					}
				}
			}
		}
		//print subtotal
		print("Subtotal for "+"Marker 6 "+icc+":    "+subtotal);		//print 6
		print("Calculated total for entire section: "+parseFloat(subtotal*sampFrac2));
		//calculated count
		mult1 = subtotal * sampFrac2;
		multReg = mult1/area1*100000;
		print(parseFloat(multReg),"profiles per 100,000",getInfo("micrometer.abbreviation"),"^2");
	} 
	//marker 7 red
	if (indexCount1 > 1 && indexRed > 0) {								//7 re
		subtotal = 0;
		for(ic = 1; ic <= nframe; ic++) {
			ic2 = "Location [re] "+ic+" of";
			icc = "(red)";												//red
			indexIC = indexOf(logGet,ic2,indexMicro);	//if doesn't exist will give -1
			//if location n of i exists
			if (indexIC > 1) {	
				indexICc = indexOf(logGet,icc,indexIC);
				ICsubtract = parseInt(indexICc-indexIC);
				//if location and color are on the same line
				if (indexIC > 1 && ICsubtract > 0 && ICsubtract < 40) {
					indexCount = indexOf(logGet,"count:",indexIC);
					indexColor = indexOf(logGet,icc,indexIC);
					if (indexColor > 0) {
						subtotal += parseInt(substring(logGet,indexCount+7,indexColor));
					}
				}
			}
		}
		//print subtotal
		print("Subtotal for "+"Marker 7 "+icc+":    "+subtotal);		//print 7
		print("Calculated total for entire section: "+parseFloat(subtotal*sampFrac2));
		//calculated count
		mult1 = subtotal * sampFrac2;
		multReg = mult1/area1*100000;
		print(parseFloat(multReg),"profiles per 100,000",getInfo("micrometer.abbreviation"),"^2");
	} 
	//marker 8 white
	if (indexCount1 > 1 && indexWhit > 0) {								//8 wh
		subtotal = 0;
		for(ic = 1; ic <= nframe; ic++) {
			ic2 = "Location [wh] "+ic+" of";
			icc = "(white)";											//white
			indexIC = indexOf(logGet,ic2,indexMicro);	//if doesn't exist will give -1
			//if location n of i exists
			if (indexIC > 1) {	
				indexICc = indexOf(logGet,icc,indexIC);
				ICsubtract = parseInt(indexICc-indexIC);
				//if location and color are on the same line
				if (indexIC > 1 && ICsubtract > 0 && ICsubtract < 40) {
					indexCount = indexOf(logGet,"count:",indexIC);
					indexColor = indexOf(logGet,icc,indexIC);
					if (indexColor > 0) {
						subtotal += parseInt(substring(logGet,indexCount+7,indexColor));
					}
				}
			}
		}
		//print subtotal
		print("Subtotal for "+"Marker 8 "+icc+":    "+subtotal);		//print 8
		print("Calculated total for entire section: "+parseFloat(subtotal*sampFrac2));
		//calculated count
		mult1 = subtotal * sampFrac2;
		multReg = mult1/area1*100000;
		print(parseFloat(multReg),"profiles per 100,000",getInfo("micrometer.abbreviation"),"^2");
	} 
	//marker 9 black
	if (indexCount1 > 1 && indexBlac > 0) {								//9 bla
		subtotal = 0;
		for(ic = 1; ic <= nframe; ic++) {
			ic2 = "Location [ba] "+ic+" of";
			icc = "(black)";											//black
			indexIC = indexOf(logGet,ic2,indexMicro);	//if doesn't exist will give -1
			//if location n of i exists
			if (indexIC > 1) {	
				indexICc = indexOf(logGet,icc,indexIC);
				ICsubtract = parseInt(indexICc-indexIC);
				//if location and color are on the same line
				if (indexIC > 1 && ICsubtract > 0 && ICsubtract < 40) {
					indexCount = indexOf(logGet,"count:",indexIC);
					indexColor = indexOf(logGet,icc,indexIC);
					if (indexColor > 0) {
						subtotal += parseInt(substring(logGet,indexCount+7,indexColor));
					}
				}
			}
		}
		//print subtotal
		print("Subtotal for "+"Marker 9 "+icc+":    "+subtotal);		//print 9
		print("Calculated total for entire section: "+parseFloat(subtotal*sampFrac2));
		//calculated count
		mult1 = subtotal * sampFrac2;
		multReg = mult1/area1*100000;
		print(parseFloat(multReg),"profiles per 100,000",getInfo("micrometer.abbreviation"),"^2");
	}  
	if (nframe == 0) {
		print("No markers detected.");
	}
	print("______");

}



//marker choices	size
//HUGE PROBLEM WITH USING "POINT TOOL..." TO SELECT MARKERS 
//KEPT CODE ADDED WORK AROUND WHERE COULD
macro "sizeMarkers" {
	//html point tool
	helpPointTool = "<html>"
		+"<h2><i><font color=black>This should only be used if the other options do not work.</i></h2><br>"
		+"<b><font color=black>Type</b><br>"
		+"<b><font color=#009999>Dot</b><font color=black> or <b><font color=#009999>Circle</b><font color=black> is recommended.<br>"
		+"- <font color=black>Choice between four shapes: <b><font color=#009999>Dot</b><font color=black> is a closed circle, <b><font color=#009999>Circle</b><font color=black> is an open circle, <b><font color=#009999>Crosshair</b><font color=black> is a plus sign, and <b><font color=#009999>Hybrid</b><font color=black> is a cross (of varying color) with a closed circle of the chosen color in the center of the cross.<br><br>"
		+"<b><font color=black>Color</b><br>"
		+"- <font color=black>A small selection of colors for the markers.<br>"
		+"- <font color=black>Choose based on what will be most visible against your background and labeling/staining, but will not be confusable with the point estimator plus-sign probe color.<br><br>"
		+"<b><font color=black>Size</b><br>"
		+"- <b><font color=#009999>Extra Large</b><font color=black> is recommended with use of <b><font color=#009999>Dot</b> <font color=black>or <b><font color=#009999>Circle</b><font color=black>.<br><br>"
		+"<b><font color=black>Label points</b><br>"
		+"- <font color=black>Only check this if you want the markers to number.<br>"
		+"- If this is checked, the markers may number sequentially and may number with a single number chosen from the drop-down under \"Counter\". This is relevant to the ImageJ source code and not part of the Coansi stereology program.<br><br>"
		+"<b><font color=black>Show all</b><br>"
		+"- <font color=black>Make sure this is checked<br><br>"
		+"<b><font color=black>Counter</b><br>"
		+"- <font color=black> If a number other than zero is selected, each marker will be labeled with the number.<br><br>"
		
		+"<h3><i><font color=#bda000>Important point: There is an internal error with the Point Tool in ImageJ that results in it not working properly. If any of the changes you have selected do not function, you can try running the \"Choose my own...\" option again. Fixing any problems with this tool are beyond the scope of this program and lie within the ImageJ source code.</i></h3><br>"
	
	Dialog.create("Markers");
	Dialog.addChoice("Select a color:", newArray(
		"white",
		"pink",
		"red",
		"orange",
		"yellow",
		"green",
		"aqua",
		"blue",
		"black"),"yellow");
	Dialog.addChoice("Select a shape:", newArray(
		"open circle",
		"closed circle"),"closed circle");
	Dialog.addCheckbox("Choose my own...",false);
	Dialog.addHelp(helpPointTool);
	Dialog.show();
	
	mColor = Dialog.getChoice;
	mShape = Dialog.getChoice;
	mChoose = Dialog.getCheckbox;
	
	if (mChoose == true) {
		run("Point Tool...");
	}
	
	if (mShape == "open circle")	{		//open circle(label) | Circle(source)
		run("Select None");
		setTool("multipoint");
		run("Point Tool...", "type=Circle color=White size=[Extra Large] label show counter=0");
		run("Point Tool...", "type=Circle color=White size=[Extra Large] show counter=0");
		if (mColor == "white"){								//white(label) | White(source)
			run("Select None");
			setTool("multipoint");
			run("Colors...", "foreground=white background=black selection=white");	
		} if (mColor == "pink"){							//pink(label) | Magenta(source)
			run("Select None");
			setTool("multipoint");
			run("Colors...", "foreground=magenta background=black selection=magenta");
		} if (mColor == "red"){								//red(label) | Red(source)
			run("Select None");
			setTool("multipoint");
			run("Colors...", "foreground=red background=black selection=red");
		} if (mColor == "orange"){							//orange(label) | Orange(source)
			run("Select None");
			setTool("multipoint");
			run("Colors...", "foreground=orange background=black selection=orange");
		} if (mColor == "yellow"){							//yellow(label) | Yellow(source)
			run("Select None");
			setTool("multipoint");
			run("Colors...", "foreground=yellow background=black selection=yellow");
		} if (mColor == "green"){							//green(label) | Green(source)
			run("Select None");
			setTool("multipoint");
			run("Colors...", "foreground=green background=black selection=green");
		} if (mColor == "aqua"){							//aqua(label) | Cyan(source)
			run("Select None");
			setTool("multipoint");
			run("Colors...", "foreground=cyan background=black selection=cyan");
		} if (mColor == "blue"){							//blue(label) | Blue(source)
			run("Select None");
			setTool("multipoint");
			run("Colors...", "foreground=blue background=black selection=blue");
		} if (mColor == "black"){							//black(label) | Black(source)
			run("Select None");
			setTool("multipoint");
			run("Colors...", "foreground=black background=black selection=black");			
		} 
	}
	if (mShape == "closed circle")	{		//closed circle(label) | Dot(source)
		run("Select None");
		setTool("multipoint");	
		run("Point Tool...", "type=Dot color=White size=[Extra Large] label show counter=0");
		run("Point Tool...", "type=Dot color=White size=[Extra Large] show counter=0");
		if (mColor == "white"){								//white(label) | White(source)
			run("Select None");
			setTool("multipoint");
			run("Colors...", "foreground=white background=black selection=white");			
		} if (mColor == "pink"){							//pink(label) | Magenta(source)
			run("Select None");
			setTool("multipoint");
			run("Colors...", "foreground=magenta background=black selection=magenta");			
		} if (mColor == "red"){								//red(label) | Red(source)
			run("Select None");
			setTool("multipoint");
			run("Colors...", "foreground=red background=black selection=red");			
		} if (mColor == "orange"){							//orange(label) | Orange(source)
			run("Select None");
			setTool("multipoint");
			run("Colors...", "foreground=orange background=black selection=orange");			
		} if (mColor == "yellow"){							//yellow(label) | Yellow(source)
			run("Select None");
			setTool("multipoint");
			run("Colors...", "foreground=yellow background=black selection=yellow");			
		} if (mColor == "green"){							//green(label) | Green(source)
			run("Select None");
			setTool("multipoint");
			run("Colors...", "foreground=green background=black selection=green");			
		} if (mColor == "aqua"){							//aqua(label) | Cyan(source)
			run("Select None");
			setTool("multipoint");
			run("Colors...", "foreground=cyan background=black selection=cyan");			
		} if (mColor == "blue"){							//blue(label) | Blue(source)
			run("Select None");
			setTool("multipoint");
			run("Colors...", "foreground=blue background=black selection=blue");			
		} if (mColor == "black"){							//black(label) | Black(source)
			run("Select None");
			setTool("multipoint");
			run("Colors...", "foreground=black background=black selection=black");			
		} 
	}
}

//java macro		size
macro "size" {
	//html help size
	helpSize = "<html>"
		+"<h1><font color=#000093>Size measurement techniques</h1>"
		+"<font color=#5c5c5c>Various techniques for measuring size (in area and volume) for nonspherical and spherical shapes, as well as thickness (in length) for elongated filamentous shapes are provided below. Some of the techniques require a clearly defined outline of the profile for accuracy. Color-coded blocks follow the name of the technique for a quick access reference on technique suitability (further elucidated under \"Design\" for each technique).<br> <font color=black>Shape: <b><font color=#009300><span>&#8718;</span> irregular <font color=#ff9224><span>&#8718;</span> spherical <font color=#9224ff><span>&#8718;</span> filamentous <font color=white><span>&#8718;</span> </b><font color=black>Clearly defined boundary: <b><font color=#009393><span>&#8718;</span> required <font color=#db0000><span>&#8718;</span> not required </b><br><br>"
		
		+"<h3><font color=#006edb>Cavalieri <font color=white><span>&#8718;</span> <font color=#009300><span>&#8718;</span><font color=#ff9224><span>&#8718;</span><font color=white><span>&#8718;</span> <font color=white><span>&#8718;</span> <font color=#009393><span>&#8718;</span><font color=#db0000><span>&#8718;</span></h3>"
		+"<font color=#black><u>Design:</u>  <font color=#5c5c5c>for <font color=#009300><b>irregular</b><font color=#5c5c5c> (nonspherical) or <b><font color=#ff9224>spherical</b><font color=#5c5c5c> shapes <font color=#009393><b>with</b> <font color=#5c5c5c>or <font color=#db0000><b>without</b><font color=#5c5c5c> a clearly defined boundary<font color=#5c5c5c><br>"
		+"<font color=#black><u>Output:</u>  <font color=#5c5c5c>area, square micrometers<br>"
		+"<font color=#black><u>Usage:</u>  <font color=#5c5c5c>A series of crosses (plus signs) will appear on the z stack. Bring the profile into focus and place markers on top of any cross that overlays the profile. Do not consider any area outside the small cross; if the cross overlays the profile, place a marker on top.<br>"
		+"<font color=#black><u>Calculation:</u>  <font color=#5c5c5c>Area contained within one tetrad of crosses is multiplied by number of markers placed.<br><br>"
		
		+"<h3><font color=#006edb>Nucleator <font color=white><span>&#8718;</span> <font color=white><span>&#8718;</span><font color=#ff9224><span>&#8718;</span><font color=white><span>&#8718;</span> <font color=white><span>&#8718;</span> <font color=#009393><span>&#8718;</span><font color=white><span>&#8718;</span></h3>"
		+"<font color=#black><u>Design:</u>  <font color=#5c5c5c>for <b><font color=#ff9224>spherical</b><font color=#5c5c5c> shapes <font color=#009393><b>with</b><font color=#5c5c5c> a clearly defined boundary<font color=#5c5c5c><br>"
		+"<font color=#black><u>Output:</u>  <font color=#5c5c5c>area, square micrometers, or volume, cubed micrometers<br>"
		+"<font color=#black><u>Usage:</u>  <font color=#5c5c5c>The user brings the profile into focus, and places a pivot marker in the center of the profile. 5 rays protruding from the pivot at 72-degree angles equidistant from each other will appear overlayed on the profile. The user then places markers on the rays at the location where they cross the boundary of the profile.<br>"
		+"<font color=#black><u>Calculation:</u>  <font color=#5c5c5c>A mean average radius is calculated based on the rays demarcated by user. The area or volume is then calculated using an assumption of a circle or spherical shape.<br><br>"
		
		+"<h3><font color=#006edb>Planimetry <font color=white><span>&#8718;</span> <font color=#009300><span>&#8718;</span><font color=#ff9224><span>&#8718;</span><font color=white><span>&#8718;</span> <font color=white><span>&#8718;</span> <font color=#009393><span>&#8718;</span><font color=white><span>&#8718;</span></h3>"
		+"<font color=#black><u>Design:</u>  <font color=#5c5c5c>for <font color=#009300><b>irregular</b><font color=#5c5c5c> (nonspherical) or <b><font color=#ff9224>spherical</b><font color=#5c5c5c> shapes <font color=#009393><b>with</b><font color=#5c5c5c> a clearly defined boundary<font color=#5c5c5c><br>"
		+"<font color=#black><u>Output:</u>  <font color=#5c5c5c>area, square micrometers<br>"
		+"<font color=#black><u>Usage:</u>  <font color=#5c5c5c>Draw a line around the perimeter of the profile. Left-click anywhere on the perimeter to place the first dot. Move to a second location along the perimeter, and left-click; this will place a second dot. Continue placing dots along the perimeter of the profile being measured until an outline is traced.<br>"
		+"<font color=#black><u>Calculation:</u>  <font color=#5c5c5c>The area of the object is calculated using geometric principles for measuring surface area (two dimensional object) of a polygon.<br><br>"
		
		+"<h3><font color=#006edb>Thickness <font color=white><span>&#8718;</span> <font color=white><span>&#8718;</span><font color=white><span>&#8718;</span><font color=#9224ff><span>&#8718;</span> <font color=white><span>&#8718;</span> <font color=#009393><span>&#8718;</span><font color=white><span>&#8718;</span></h3>"
		+"<font color=#black><u>Design:</u>  <font color=#5c5c5c>for <font color=#9224ff><b>elongated, filamentous</b> <font color=#5c5c5c>shapes <font color=#009393><b>with</b><font color=#5c5c5c> a clearly defined boundary<font color=#5c5c5c><br>"
		+"<font color=#black><u>Output:</u>  <font color=#5c5c5c>length, micrometers<br>"
		+"<font color=#black><u>Usage:</u> <font color=#5c5c5c>An axis through the longest part of the profile is aligned by the user. The user then clicks on the the end limits of the profile that are perpendicular to the this axis. A series of three lines is then populated and the user places markers at the locations where the markers cross the boundary of the profile.<br>"
		+"<font color=#black><u>Calculation:</u>  <font color=#5c5c5c>A mean average length based on the three measurements is calculated.<br><br>"

	Dialog.create("Coansi  |  Size Measurement Options");
	Dialog.addRadioButtonGroup("Select which probe you want to use for size measurement.", newArray(
		"Point Estimator    (for irregular shapes)",
		"Outline    (for irregular shapes)"), 2,1,RBG_szTech);
	//"Thickness    (for elongated filamentous shapes)",
	//"Radial Spoke Intersection    (for spheroid shapes)",
	Dialog.addHelp(helpSize);
	Dialog.show();
	
	
	szTech = Dialog.getRadioButton();

	
	//print 
	print("\n______");
	print("Size measurement using ",szTech);
	
	
	//point estimator
	if (szTech == "Point Estimator    (for irregular shapes)"){
		run("Select None");
		//dialog box
		while (true) {
			Dialog.create("Coansi  |  Point Estimator");
			Dialog.addSlider("Density of points:",1,5,S_peEst);
			Dialog.setInsets(-5,50,0);
			Dialog.addMessage("farther apart = [1]                 closer together = [5]");
			Dialog.addChoice("Choose color for probe:",newArray(
				"RANDOM SELECTION",
				"black",
				"white",
				"gray (dark)",
				"gray (light)",
				"blue (dark)",
				"blue (bright)",
				"blue (light)",
				"turquoise",
				"green (dark)",
				"green (bright)",
				"green (light)",
				"yellow",
				"orange (dark)",
				"orange (light)",
				"red (dark)",
				"red (bright)",
				"pink (dark)",
				"pink (bright)",
				"pink (light)",
				"purple (dark)",
				"purple (bright)",
				"purple (light)"),C_peCol);
			Dialog.setInsets(20,0,-15);			
			Dialog.addMessage("Advanced options");
			Dialog.addCheckbox("Use zoom on individual profiles  [100X, 60X]",CB_peZoom);
			Dialog.setInsets(-5,50,0);
			Dialog.addMessage("For stacks acquired at higher magnifications");
			Dialog.addCheckbox("Automatically take a snapshot when getting results",CB_pePic);
			Dialog.addCheckbox("Suppress all messages",CB_peSupp);
			Dialog.setInsets(-5,50,0);
			Dialog.addMessage("Only select this if you know what you are doing in Coansi. \nYou must follow a series of steps through which future \nnotifications guide you. This option will suppress those \nnotifications for the point estimator process.");
			Dialog.addCheckbox("Make a montage for reference",CB_peMon);
			Dialog.setInsets(-5,50,0);
			Dialog.addMessage("Optimized for dark background stacks");
			Dialog.show();
			
			peEst = round(Dialog.getNumber);			//density of points
			peCol = Dialog.getChoice;					//color of points
			peZoom = Dialog.getCheckbox;				//zoom on individual cells
			pePic = Dialog.getCheckbox;					//capture image while doing Get Results
			peSupp = Dialog.getCheckbox;				//suppress notifications
			peMon = Dialog.getCheckbox;					//make a montage of stack
			
			
			CB_pePic = pePic;
			CB_peSupp = peSupp;
			peEst2 = 0;
			peColNum = 0;

			//error message, return to dialog
			if (peEst > 5 || peEst < 1) {
				showMessage("ERROR","You must choose a whole number between [1] and [5].");
				continue;		//return to dialog box
			}
			
			//print 
			print("Grid selection  ",peEst,"(density of probe)");
			
			//peEst
			if (peEst == 5) {
				peEst2 = 4;					//4^2 pixels
			} if (peEst == 4) {
				peEst2 = 5;					//5^2 pixels
			} if (peEst == 3) {
				peEst2 = 6;					//6^2 pixels
			} if (peEst == 2) {
				peEst2 = 7;					//7^2 pixels
			} if (peEst == 1) {
				peEst2 = 8;					//8^2 pixels
			}
			
			//peCol to peColNum
			if (peCol == "black") {						//setForegroundColor(5,5,5);
				peColNum = 1;
			} if (peCol == "white") {					//setForegroundColor(250,250,250);
				peColNum = 2;
			} if (peCol == "gray (dark)") {				//setForegroundColor(105,105,105);
				peColNum = 3;
			} if (peCol == "gray (light)") {			//setForegroundColor(205,205,205);
				peColNum = 4;
			} if (peCol == "blue (dark)") {				//setForegroundColor(5,5,155);
				peColNum = 5;
			} if (peCol == "blue (bright)") {			//setForegroundColor(5,5,255);
				peColNum = 6;
			} if (peCol == "blue (light)") {			//setForegroundColor(105,155,255);
				peColNum = 7;
			} if (peCol == "turquoise") {				//setForegroundColor(5,155,155);
				peColNum = 8;
			} if (peCol == "green (dark)") {			//setForegroundColor(5,155,5);
				peColNum = 9;
			} if (peCol == "green (bright)") {			//setForegroundColor(5,205,5);
				peColNum = 10;
			} if (peCol == "green (light)") {			//setForegroundColor(155,255,155);
				peColNum = 11;
			} if (peCol == "yellow") {					//setForegroundColor(255,255,5);
				peColNum = 12;
			} if (peCol == "orange (dark)") {			//setForegroundColor(255,105,5);
				peColNum = 13;
			} if (peCol == "orange (light)") {			//setForegroundColor(255,155,5);
				peColNum = 14;
			} if (peCol == "red (dark)") {				//setForegroundColor(155,5,5);
				peColNum = 15;
			} if (peCol == "red (bright)") {			//setForegroundColor(255,5,5);
				peColNum = 16;
			} if (peCol == "pink (dark)") {				//setForegroundColor(255,5,155);
				peColNum = 17;
			} if (peCol == "pink (bright)") {			//setForegroundColor(255,105,205);
				peColNum = 18;
			} if (peCol == "pink (light)") {			//setForegroundColor(255,155,205);
				peColNum = 19;
			} if (peCol == "purple (dark)") {			//setForegroundColor(105,5,155);
				peColNum = 20;
			} if (peCol == "purple (bright)") {			//setForegroundColor(205,5,255);
				peColNum = 21;
			} if (peCol == "purple (light)") {			//setForegroundColor(205,205,255);
				peColNum = 22;
			} if (peCol == "RANDOM SELECTION") {		//random
				peColNum = round(random()*21+1);		//only selects from available color choices
			}

			//peColNum to color and peCol redefine for window title with random selection
			if (peColNum == 1) {
				setForegroundColor(5,5,5);
				peCol = "black";
			} if (peColNum == 2) {
				setForegroundColor(250,250,250);
				peCol = "white";
			} if (peColNum == 3) {
				setForegroundColor(105,105,105);
				peCol = "gray (dark)";
			} if (peColNum == 4) {
				setForegroundColor(205,205,205);
				peCol = "gray (light)";
			} if (peColNum == 5) {
				setForegroundColor(5,5,155);
				peCol = "blue (dark)";
			} if (peColNum == 6) {
				setForegroundColor(5,5,255);
				peCol = "blue (bright)";
			} if (peColNum == 7) {
				setForegroundColor(105,155,255);
				peCol = "blue (light)";
			} if (peColNum == 8) {
				setForegroundColor(5,155,155);
				peCol = "turquoise";
			} if (peColNum == 9) {
				setForegroundColor(5,155,5);
				peCol = "green (dark)";
			} if (peColNum == 10) {
				setForegroundColor(5,205,5);
				peCol = "green (bright)";
			} if (peColNum == 11) {
				setForegroundColor(155,255,155);
				peCol = "green (light)";
			} if (peColNum == 12) {
				setForegroundColor(255,255,5);
				peCol = "yellow";
			} if (peColNum == 13) {
				setForegroundColor(255,105,5);
				peCol = "orange (dark)";
			} if (peColNum == 14) {
				setForegroundColor(255,155,5);
				peCol = "orange (light)";
			} if (peColNum == 15) {
				setForegroundColor(155,5,5);
				peCol = "red (dark)";
			} if (peColNum == 16) {
				setForegroundColor(255,5,5);
				peCol = "red (bright)";
			} if (peColNum == 17) {
				setForegroundColor(255,5,155);
				peCol = "pink (dark)";
			} if (peColNum == 18) {
				setForegroundColor(255,105,205);
				peCol = "pink (bright)";
			} if (peColNum == 19) {
				setForegroundColor(255,155,205);
				peCol = "pink (light)";
			} if (peColNum == 20) {
				setForegroundColor(105,5,155);
				peCol = "purple (dark)";
			} if (peColNum == 21) {
				setForegroundColor(205,5,255);
				peCol = "purple (bright)";
			} if (peColNum == 22) {
				setForegroundColor(205,205,255);
				peCol = "purple (light)";
			}

			//size in pixels
			getDimensions(width,height,channels,slices,frames);
			wStack = width;
			hStack = height;
			dStack = slices;
		

			//random start
			ranthrowX = random()*peEst2*peEst2;				//x offset
			ranthrowY = random()*peEst2*peEst2;				//y offset


			//make montage for counting
			if(peMon == true) {
				mWindow = getTitle();
				run("Z Project...", "projection=[Sum Slices]");
				rename("Sum Intensity");
				selectWindow(mWindow);
				run("Z Project...", "projection=[Average Intensity]");
				rename("Mean Intensity");
				selectWindow(mWindow);
				run("Z Project...", "projection=[Standard Deviation]");
				rename("StdDev Intensity");
				selectWindow(mWindow);
				run("Z Project...", "projection=[Min Intensity]");
				rename("Minimum Intensity");
				selectWindow(mWindow);
				run("Z Project...", "projection=[Max Intensity]");
				rename("Maximum Intensity");
				//lighten
				selectWindow("Sum Intensity");				//sum light
				run("Duplicate...", "title=[Sum-Lighten Intensity]");
				run("Brightness/Contrast...");
				setMinAndMax(0, 165);
				run("Apply LUT", "stack");
				selectWindow("B&C");
				run("Close");
				selectWindow("Mean Intensity");				//mean light
				run("Duplicate...", "title=[Mean-Lighten Intensity]");
				run("Brightness/Contrast...");
				setMinAndMax(0, 165);
				run("Apply LUT", "stack");
				selectWindow("B&C");
				run("Close");
				selectWindow("StdDev Intensity");			//stddev light
				run("Duplicate...", "title=[StdDev-Lighten Intensity]");
				run("Brightness/Contrast...");
				setMinAndMax(0, 165);
				run("Apply LUT", "stack");
				selectWindow("B&C");
				run("Close");
				selectWindow("Minimum Intensity");			//min light
				run("Duplicate...", "title=[Minimum-Lighten Intensity]");
				run("Brightness/Contrast...");
				setMinAndMax(0, 165);
				run("Apply LUT", "stack");
				selectWindow("B&C");
				run("Close");
				selectWindow("Maximum Intensity");			//max light
				run("Duplicate...", "title=[Maximum-Lighten Intensity]");
				run("Brightness/Contrast...");
				setMinAndMax(0, 165);
				run("Apply LUT", "stack");
				selectWindow("B&C");
				run("Close");
				//darken
				selectWindow("Sum Intensity");				//sum dark
				run("Duplicate...", "title=[Sum-Darken Intensity]");
				run("Brightness/Contrast...");
				setMinAndMax(55, 305);
				run("Apply LUT", "stack");
				selectWindow("B&C");
				run("Close");
				run("Brightness/Contrast...");
				setMinAndMax(0, 165);
				run("Apply LUT", "stack");
				selectWindow("B&C");
				run("Close");
				selectWindow("Mean Intensity");				//mean dark
				run("Duplicate...", "title=[Mean-Darken Intensity]");
				run("Brightness/Contrast...");
				setMinAndMax(55, 305);
				run("Apply LUT", "stack");
				selectWindow("B&C");
				run("Close");
				run("Brightness/Contrast...");
				setMinAndMax(0, 165);
				run("Apply LUT", "stack");
				selectWindow("B&C");
				run("Close");
				selectWindow("StdDev Intensity");			//stddev dark
				run("Duplicate...", "title=[StdDev-Darken Intensity]");
				run("Brightness/Contrast...");
				setMinAndMax(55, 305);
				run("Apply LUT", "stack");
				selectWindow("B&C");
				run("Close");
				run("Brightness/Contrast...");
				setMinAndMax(0, 165);
				run("Apply LUT", "stack");
				selectWindow("B&C");
				run("Close");
				selectWindow("Minimum Intensity");			//min dark
				run("Duplicate...", "title=[Minimum-Darken Intensity]");
				run("Brightness/Contrast...");
				setMinAndMax(55, 305);
				run("Apply LUT", "stack");
				selectWindow("B&C");
				run("Close");
				run("Brightness/Contrast...");
				setMinAndMax(0, 165);
				run("Apply LUT", "stack");
				selectWindow("B&C");
				run("Close");
				selectWindow("Maximum Intensity");			//max dark
				run("Duplicate...", "title=[Maximum-Darken Intensity]");
				run("Brightness/Contrast...");
				setMinAndMax(55, 305);
				run("Apply LUT", "stack");
				selectWindow("B&C");
				run("Close");
				run("Brightness/Contrast...");
				setMinAndMax(0, 165);
				run("Apply LUT", "stack");
				selectWindow("B&C");
				run("Close");
				run("Images to Stack", "name=temporary title=Intensity use");
				setForegroundColor(205,205,205);
				run("Make Montage...", "columns=5 rows=3 scale=0.20 border=1 font=14 label use");
				rename("Intensity Montage_Coansi_"+mWindow);
				montageWindow = getTitle();
				selectWindow("temporary");
				close();
				selectWindow(mWindow);
			}

		
			//duplicate stack
			run("Select None");
			run("Duplicate...", "duplicate");
			setLocation(screenWidth/2, screenHeight/7);
			rename("Coansi  |  POINT ESTIMATOR  |  "+peCol+"  |  "+peEst2*peEst2+" pixel grid  |  ");


			for (yy = -1; yy <= hStack/(peEst2*peEst2); yy++) {
				for (xx = -1; xx <= wStack/(peEst2*peEst2); xx++) {
					a = (xx*peEst2*peEst2)+ranthrowX;				//columns (x axis move)
					b = (yy*peEst2*peEst2)+ranthrowY;				//rows (y axis move)
					setTool("line");
					run("Line Width...", "line=1");
					makeLine(a,b-5,a,b+5);
					run("Draw", "stack");
					makeLine(a-5,b,a+5,b);
					run("Draw", "stack");
				}
			}
			run("Select None");
			
			//choose marker
			if(peSupp == false) {
				run("sizeMarkers");
			} else {
				setTool("multipoint");
				run("Point Tool...", "type=Dot color=Yellow size=[Extra Large] show counter=0");
			}

			//start dialog
			if (peZoom == false && peSupp == false) {
				showMessage("Coansi  |  Point Estimator","Place a marker on every cross that is overlayed on the profile. \n \n - If you need to change the marker, select \"Markers\" from the right-click menu under SIZE MEASUREMENTS. \n - When all points have been placed, select \"Get Size Measurement\" from the right-click menu. \n - Output will be printed to the \"Log\" window.\n \nIf you have questions, use the \"Help\" from the right-click menu.");
			}
			//zoom
			if (peZoom == true) {				//step 1 on toolbar
				showMessage ("Coansi  |  Point Estimator","Place markers on the profiles you want to measure.\n \nThen click the orange number 2 on the toolbar.");
				exit;						//rest of the process relies on toolbar
			}
			break;
		}
	}
	
	//planimetry
	if (szTech == "Outline    (for irregular shapes)"){
		run("Select None");
		//dialog box
		Dialog.create("Coansi  |  Planimetry Size Measurement");
		Dialog.addRadioButtonGroup("Choose a color to draw with:",newArray(
				"aqua",
				"black",
				"blue",
				"green",
				"orange",
				"pink",
				"red",
				"white",
				"yellow"),4,3,RBG_plaCol);
		Dialog.setInsets(20,0,-15);			
		Dialog.addMessage("Advanced options");
		Dialog.addCheckbox("Use zoom on individual profiles  [100X, 60X]",CB_olZoom);
		Dialog.setInsets(-5,50,0);
		Dialog.addMessage("For stacks acquired at higher magnifications");
		Dialog.addCheckbox("Automatically take a snapshot when getting results",CB_olPic);
		Dialog.addCheckbox("Suppress all messages",CB_olSupp);
		Dialog.setInsets(-5,50,0);
		Dialog.addMessage("Only select this if you know what you are doing in Coansi. \nYou must follow a series of steps through which future \nnotifications guide you. This option will suppress those \nnotifications for the point estimator process.");
		Dialog.show();
		
		plaCol = Dialog.getRadioButton;
		olZoom = Dialog.getCheckbox;
		olPic = Dialog.getCheckbox;					//capture image while doing Get Results
		olSupp = Dialog.getCheckbox;				//suppress notifications
		
		CB_olPic = olPic;
		CB_olSupp = olSupp;
		
		//duplicate stack
			run("Select None");
			run("Duplicate...", "duplicate");
			setLocation(screenWidth/2, screenHeight/7);
			rename("Coansi  |  OUTLINE  |  "+plaCol+"  |  ");		
		
		if (plaCol == "aqua"){
			setTool("polygon");
			run("Colors...", "selection=cyan");
		} if (plaCol == "black"){
			setTool("polygon");
			run("Colors...", "selection=black");
		} if (plaCol == "blue"){
			setTool("polygon");
			run("Colors...", "selection=blue");
		} if (plaCol == "green"){
			setTool("polygon");
			run("Colors...", "selection=green");
		} if (plaCol == "orange"){
			setTool("polygon");
			run("Colors...", "selection=orange");
		} if (plaCol == "pink"){
			setTool("polygon");
			run("Colors...", "selection=magenta");
		} if (plaCol == "red"){
			setTool("polygon");
			run("Colors...", "selection=red");
		} if (plaCol == "white"){
			setTool("polygon");
			run("Colors...", "selection=white");
		} if (plaCol == "yellow"){
			setTool("polygon");
			run("Colors...", "selection=yellow");
		}
		
		if (olSupp == false) {
			showMessage("Trace the perimeter of the profile you want to measure.\n When completed, select \"Get Size Measurement\" from the right-click menu.");
		}
		setTool("polygon");
	}
}



//size results
macro "sizeResults" {
	close("Results");
	if (isOpen("Log")) {
		logGet = getInfo("log");
		indexTech1 = lastIndexOf(logGet," using ")+8;
		indexTech2 = indexOf(logGet,"(for",indexTech1)-4;
		tech = substring(logGet,indexTech1, indexTech2);
	} else {
		exit("ERROR. No results are detected.\n \nUse the General Problems under Help in the right-click menu if you need assistance.");
	}

	if (tech == "Point Estimator") {
		peW = getTitle();
		run("Set Measurements...", "area stack redirect=None decimal=3");
		run("Measure");
		count = nResults;
		outlineZloc = getResult("Slice");
		run("Summarize");
		if (count >= 1) {
			for (i = 0; i < nResults; i++) {
				ifLabel = getResultString("Label",i);
				if (ifLabel == "Min") {
					min = parseInt(getResult("Slice",i));
				} if (ifLabel == "Max") {
					max = parseInt(getResult("Slice",i));
				}
			}
		}
		close("Results");
		zInterval = parseFloat(max-min+1);
		
		//size in microns
		meta = getImageInfo();
		micro = getInfo("micrometer.abbreviation");
		indexMicro = indexOf(meta,micro);
		if (indexMicro >= 0) {							//micron size if in metadata
			//width
			indexW = indexOf(meta,"Width: ")+6;
			indexW2 = indexOf(meta,micro,indexW);
			wMicron = parseFloat(substring(meta,indexW,indexW2));
			//height
			indexH = indexOf(meta,"Height: ")+7;
			indexH2 = indexOf(meta,micro,indexH);
			hMicron = parseFloat(substring(meta,indexH,indexH2));
			//depth
			indexD = indexOf(meta,"Depth: ")+6;
			indexD2 = indexOf(meta,micro,indexD);
			dMicron = parseFloat(substring(meta,indexD,indexD2));
		} if (indexMicro < 0) {							//user input of micron size
			Dialog.create("Enter micron dimensions");
			Dialog.addMessage("The program could not find dimensions for this stack. \nPlease enter the micron measurements:");
			Dialog.addNumber("X axis, width",90);
			Dialog.addNumber("Y axis, height",90);
			Dialog.addNumber("Z axis, depth",25);
			Dialog.show();
			wMicron = Dialog.getNumber;
			hMicron = Dialog.getNumber;
			dMicron = Dialog.getNumber;
		}

		//size in pixels
		getDimensions(width,height,channels,slices,frames);
		wStack = width;
		hStack = height;
		dStack = slices;
		
		//conversion
		if (isOpen("Log")) {
			logGet = getInfo("log");
			indexGrid1 = lastIndexOf(logGet,"Grid selection  ")+15;
			indexGrid2 = indexOf(logGet,"(density",indexGrid1)-1;
			gridPoint = parseInt(substring(logGet,indexGrid1,indexGrid2));
			gridPointxy = 1;
			if (gridPoint == 5) {
				gridPointxy = 16;			//16x16 pixels
			} if (gridPoint == 4) {
				gridPointxy = 25;			//25x25 pixels
			} if (gridPoint == 3) {
				gridPointxy = 36;			//36x36 pixels
			} if (gridPoint == 2) {
				gridPointxy = 49;			//49x49 pixels
			} if (gridPoint == 1) {
				gridPointxy = 64;			//64x64 pixels
			}

			wPer = (wMicron/wStack)*gridPointxy;
			hPer = (hMicron/hStack)*gridPointxy;
			dPer = dMicron/dStack;
			
			//units single
			zVar = zInterval * dPer;
			//units square
			xyVar = wPer * hPer;
			peArea = xyVar * count;
			//units cubed
			if (zInterval > 1) {
				peVol = peArea * zVar;
			}
			getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
			hour1 = hour;
			if (hour > 12) {
				hour1 = hour - 12;
			} min = minute;
			if (min < 10) {
				min = "0" + min;
			} ampm = " a.m.";
			if (hour >= 12) {
				ampm = " p.m.";
			}

			print(peArea+" "+micro+"^2    measured at Slice",outlineZloc,"    ",hour1,":",min,ampm);
			selectWindow(peW);
			if (CB_pePic == true) {
				run("Capture Image");
				rename(peW+"_"+hour+"_"+min);
			}
			//draw a marker on the profile just measured
			selectWindow(peW);
			getBoundingRect(x,y,width,height);
			widthC = minOf(getWidth(),getHeight())/100;
			heightC = widthC;
			brx = x;
			bry = y;
			brwidth = width;
			brheight = height;

			makeOval(brx+brwidth/2,bry+brheight/2,widthC,heightC);
			setForegroundColor(255,255,5);
			run("Draw","stack");
			run("Select None");
			
			if (CB_peSupp == false) {
				showMessage("Coansi  |  Point estimator","You may count another profile.");
			}
		}
	}
	
	if (tech == "Outline") {
		olW = getTitle();
		run("Set Measurements...", "area stack redirect=None decimal=3");
		run("Measure");
		outlineArea = getResult("Area");				//in microns
		outlineZloc = getResult("Slice");
		selectWindow("Results");
		run("Close");
		getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
		hour1 = hour;
		if (hour > 12) {
			hour1 = hour - 12;
		} min = minute;
		if (min < 10) {
			min = "0" + min;
		} ampm = " a.m.";
		if (hour >= 12) {
			ampm = " p.m.";
		}
		print(outlineArea,getInfo("micrometer.abbreviation"),"^2    measured at Slice",outlineZloc,"    ",hour1,":",min,ampm);
		
		selectWindow(olW);
		if (CB_olPic == true) {
			run("Capture Image");
			rename(olW+"_"+hour+"_"+min);
		}
		//draw a marker on the profile just measured
		selectWindow(olW);
		getBoundingRect(x,y,width,height);
		widthC = minOf(getWidth(),getHeight())/100;
		heightC = widthC;
		brx = x;
		bry = y;
		brwidth = width;
		brheight = height;

		makeOval(brx+brwidth/2,bry+brheight/2,widthC,heightC);
		setForegroundColor(255,255,5);
		run("Draw","stack");
		run("Select None");
		
		if (CB_olSupp == false) {
			showMessage("Coansi  |  Outline","You may count another profile.");
		}
	}
}


//all helps for right click menu		pmcmd
macro "help"{
	//html
	helpDefinitions = "<html>"
		+"<h1><font color=black>Definitions</h1>"
		+"<dl>"

			+"<dt><b><font color=red>10X, 100X</b></dt>"
			+"<dd><font color=black>The magnification on the objective lens used when acquiring the z-stack or image. <font color=gray>Typically a 10X stack is a section magnified 100 times or 120 times, and 100X magnified 1000 times or 1200 times.</dd>"
			
			+"<dt><b><font color=red>area</b></dt>"
			+"<dd><font color=black>A two dimensional measurement of space.</dd>"

			+"<dt><b><font color=red>atlas</b></dt>"
			+"<dd><font color=black>A published collection of sections with detailed listings of regions that is accepted as a consensus mapping. <font color = gray>For example, popular atlases include the Mouse Brain Library (MBL) Mouse Brain Atlas (online) and the Mai and Paxinos (et al.) Atlas of the Human Brain (printed).</dd>"
					
			+"<dt><b><font color=red>Cavalieri estimator</b></dt>"
			+"<dd><font color=black>A tool for point to area conversion, used to estimate the size of an object. <font color=gray>As a general rule, effective estimates can be made with one degree of difference in dimensions (point to area or area to volume), so long as multiple samples are taken and the shape factor is considered. As such this is generally not an acceptable tool to determine regional volume. However, in the case of z-stacks and density measurements, the Cavalieri estimator may by multiplied by the distance in the z-stack (depth through which profiles are resolvable) to derive a theoretical volume for density normalizations. This would not be acceptable for an entire organ; for example, estimating the volume of a three-dimensional heart based on a snapshot would not be reliable.</dd>"
			
			+"<dt><b><font color=red>channel</b></dt>"
			+"<dd><font color=black>A filter that selects a specific wavelength range of fluorophore emissions. Red and green are standard channels. When overlapped as light, they make yellow.</dd>"	

			+"<dt><b><font color=red>counting frame</b></dt>"
			+"<dd><font color=black>A two-dimensional figure with inclusion (green or thin gray) and exclusion (red or thick black) lines that is overlayed on a section to aide unbiased counting when sampling across a larger area."
				+"<blockquote><font color=white>````<font color=red>|<font color=white>`````````````````````<b><font color=black>|</b><font color=white>`````````````````"
				+"<br><font color=white>````<font color=red>|<font color=green>_________<font color=white>````````````<b><font color=black>|</b><font color=silver>_________<font color=white>````````"
				+"<br><font color=white>````<font color=red>|<font color=white>`````````<font color=green>|<font color=white>``````````` <b><font color=black>|</b>`````````<font color=silver>|<font color=white>```````"
				+"<br><font color=white>````<font color=red>|<font color=white>`````````<font color=green>|<font color=white>``````````` <b><font color=black>|</b>`````````<font color=silver>|<font color=white>```````"
				+"<br><font color=white>````<font color=red>|<font color=white>`````````<font color=green>|<font color=white>``````````` <b><font color=black>|</b>`````````<font color=silver>|<font color=white>```````"
				+"<br><font color=white>````<font color=red>|_________<font color=green>|<font color=white>``````````` <b><font color=black>|________</b><font color=silver>|<font color=white>```````"
				+"<br><font color=white>````````````` <font color=red>|<font color=white>````````````````````` <b><font color=black>|</b><font color=white>```````"
				+"<br><font color=white>````````````` <font color=red>|<font color=white>````````````````````` <b><font color=black>|</b><font color=white>```````</blockquote></dd>"

			+"<dt><b><font color=red>density</b></dt>"
			+"<dd><font color=black>Number of units per an area or volume.</dd>"
		
			+"<dt><b><font color=red>disector</b></dt>"
			+"<dd><font color=black>The three-dimensional space within which objects are counted, seen during counting as the two-dimensional red exclusion and green inclusion lines that make up the counting frame.</dd>"

			+"<dt><b><font color=red>grid</b></dt>"
			+"<dd><font color=black>An unseen division of the section that is used for sampling. The counting frame top left corner aligns with the grid top left corner. <i>See diagram under \"sampling fraction\".<\i></dd>"
			+"<dt><b><font color=red>isotropic</b></dt>"
			+"<dd><font color=black>A shape with regular features and the smallest surface area for the volume or area contained. <font color = gray>For example, a sphere (surface area:volume) or a circle (surface area:area) is perfectly isotropic, whereas a dandelion or sponge would be poorly isotropic (or anisotropic - \"without isotropy\").</dd>"
				
			+"<dt><b><font color=red>log</b></dt>"
			+"<dd><font color=black>A specific text window that opens up and keeps a running record of markers counted. <font color = gray>The \"Log\" window should be saved as a .txt file or the contents copied and saved in a .xlsx or .docx file.</dd>"
				
			+"<dt><b><font color=red>magenta</b></dt>"
			+"<dd><font color=black>The preferred alternative to red to bypass color blindness. This corrects deficits derived with red-green color blindness, while not affecting other forms.</dd>"
		
			+"<dt><b><font color=red>marker</b></dt>"
			+"<dd><font color=black>A point select tool to temporarily \"mark\" where the profile(s) of interest are.</dd>"

			+"<dt><b><font color=red>metainformation</b></dt>"
			+"<dd><font color=black>Extra data assigned to an image or stack that is used for identification and calculations in later code. <font color = gray>For example, metainformation allows the synchronization of markers placed on the zoomed-in stacks to the reference stack.</dd>"
				
			+"<dt><b><font color=red>normalize</b></dt>"
			+"<dd><font color=black>A calculation performed on data to make subjects or groups comparable to each other. Data should be normalized when the experimenter thinks raw values are subjected to experimental bias.</dd>"
			
			+"<dt><b><font color=red>planimetry</b></dt>"
			+"<dd><font color=black>Classic geometrical principles applied to the calculation of a standard or nonstandard space. <font color = gray>In two dimensions, this may be thought of as \"measurement by planes,\" or the use of lines and angles to derive the area of a polygon.</dd>"

			+"<dt><b><font color=red>polygon</b></dt>"
			+"<dd><font color=black>A two-dimensional shape with straight line edges of any number and size. Generally the area of interest will be demarcated with a polygon.</dd>"
					
			+"<dt><b><font color=red>profile(s)</b></dt>"
			+"<dd><font color=black>Whatever you're looking at. Neurons, puncta, vacuoles, etc. are grouped into the general word \"profiles.\"</dd>"

			+"<dt><b><font color=red>resolution</b></dt>"
			+"<dd><font color=black>The ability to distinguish two points as two points. This is lost with lower magnification and increased with higher magnification.</dd>"

			+"<dt><b><font color=red>ROI</b></dt>"
			+"<dd><font color=black><u>R</u>egion <u>o</u>f <u>i</u>nterest. The territory that one is looking at or counting within.</dd>"

			+"<dt><b><font color=red>sampling</b></dt>"
			+"<dd><font color=black>A smaller subset of a region that can be reasonably used for measurements and is thought to be representative of the whole region. <font color = gray>For example, you wouldn't sample the corpus callosum for glutamatergic cell counts and consider it representative of the neocortex. You might however sample a small area of the neocortex for glutamatergic cell counts and consider the result representative of a larger neocortex area.</dd>"
				
			+"<dt><b><font color=red>sampling fraction</b></dt>"
			+"<dd><font color=black>The percentage of region sampled as represented by a fraction. The inverse of this number will be used as a multiplication factor when calculating final numbers. <font color =gray>For example, a sampling fraction for 20 % sampling is 1/5 and the multiplication factor is 5/1."
				+"<br><blockquote><font color=gray>In the diagram, 13.1 % of the <font color=black>grid <font color=gray>(<font color=black>black <font color=gray>lines) is sampled by the <font color=blue>counting frame <font color=gray>(<font color=blue>blue <font color=gray>area). The number of profiles counted across all counting frames would be multiplied by 7.6, or <font color=black>100<font color=gray>/<font color=blue>13.1<font color=gray> which is the inverse of <font color=blue>13.1<font color=gray>/<font color=black>100<font color=gray>, 13.1 % - the sampling fraction."
				+"<br><font color=white>````<font color=black>|<font color=white>````````````````````` <font color=black>|<font color=white>```"
				+"<br><font color=black> _ _ _|<font color=blue>______ <font color=black>_ _ _ _ _ _ _ _ _ _ |<font color=blue>__"
				+"<br><font color=white>````<font color=blue>|CFCFCF|<font color=white>```````````````<font color=blue>|CF"
				+"<br><font color=white>````<font color=blue>|CFCFCF|<font color=white>```````````````<font color=blue>|CF"
				+"<br><font color=white>````<font color=blue>|CFCFCF|<font color=white>```````````````<font color=blue>|CF"
				+"<br><font color=white>````<font color=blue>|______|<font color=white>```````````````<font color=blue>|__"
				+"<br><font color=white>````<font color=black>|<font color=white>````````````````````` <font color=black>|<font color=white>```"	
				+"<br><font color=white>````<font color=black>|<font color=white>````````````````````` <font color=black>|<font color=white>```"
				+"<br><font color=white>````<font color=black>|<font color=white>````````````````````` <font color=black>|<font color=white>```"
				+"<br><font color=white>````<font color=black>|<font color=white>````````````````````` <font color=black>|<font color=white>```"
				+"<br><font color=black> _ _ _|<font color=blue>______ <font color=black>_ _ _ _ _ _ _ _ _ _ |<font color=blue>__"
				+"<br><font color=white>````<font color=blue>|CFCFCF|<font color=white>```````````````<font color=blue>|CF"
				+"<br><font color=white>````<font color=blue>|CFCFCF|<font color=white>```````````````<font color=blue>|CF</blockquote></dd>"

			+"<dt><b><font color=red>slides or sections</b></dt>"
			+"<dd><font color=black>Usually referring to the area seen in one file (image or stack). These terms are used interchangeably in this program and refer to the territory contained in one slice along the plane of cut (coronal, longitudinal, transverse).</dd>"
				
			+"<dt><b><font color=red>SRS</b></dt>"
			+"<dd><font color=black><u>S</u>ystematic <u>r</u>andom <u>s</u>ampling. This refers to a random start position with systematic grid thereafter to sample a region of interest, allowing for quicker counting of profiles than assessing the whole region.</dd>"

			+"<dt><b><font color=red>stack</b></dt>"
			+"<dd><font color=black>A series of images taken at a specified interval and \"stacked\" into a composite that the user can scan through. The stack is usually through a volume (z-axis) or through time (t-axis).</dd>"
					
			+"<dt><b><font color=red>unbiased</b></dt>"
			+"<dd><font color=black>A term to describe techniques that are optimized to have the lowest experimental error possible. Stereology is considered to be unbiased.</dd>"
					
			+"<dt><b><font color=red>volume</b></dt>"
			+"<dd><font color=black>A three-dimensional measurement of space.</dd>"

		+"</dl>"
	
	//html general problems
	helpGeneralProblems = "<html>"
		+"<h1><font color=navy>General Problems</h1>"
		+"<h4><font color=purple>I am trying to place a marker but it just keeps drawing dotted lines.</h4>"
		+"<font color=navy>Right click on <i>Step 4. Markers</i> and re-select the marker you want.<br><br>"
		+"<h4><font color=purple>I want to use more than one marker.</h4>"
		+"<font color=navy>After placing markers of one type, right-click and select <i>Step 5. Save Counts.</i> Wait for that macro to finish, then select <i>Step 4. Markers</i> and choose a different marker for the next object.<br><br>"
		+"<h4><font color=purple>The program keeps telling me to draw a region but I already did.</h4>"
		+"<font color=navy>You need to make sure you are drawing the region on the stack labeled <i>reference</i>. Right click and select <i>Step 2. Region Outline.</i><br><br>"
		+"<h4><font color=purple>I can't get the region outline to end.</h4>"
		+"<font color=navy>Right click and it will auto-close.<br><br>"
		+"<h4><font color=purple>I get a dialog window that says  <tt>Macro Error</tt>  at the top and a checkbox next to <tt>Show  \"Debug\" Window</tt>  at the bottom.</h4>"
		+"<font color=navy><br>This may indicate an error with the code or an error caused by different ImageJ versions between coder and user or an error with previously loaded plugins (on the coder or user end). You can try upgrading ImageJ or troubleshooting the script yourself. The <i>Macro Error</i> dialog box will usually tell you an accurate line for the error but may not be helpful in diagnosing the exact reason for the code fail.<br>"
	
	//help image prep
	helpImagePrep = "<html>"
		+"<h1>List of dialog box options for <font color=orange>Step 1. Stack Preparation...</h1>"
		+"<h4><font color=orange>Flatten dual channels</h4>"
		+"<font color=teal>Collapses two channels into one composite stack. This will not alter the z-axis (depth) or t-axis (time). <br><u>This option should only be performed once on a stack.</u>"
		+"<h4><font color=orange>Extract green channel only</h4>"
		+"<font color=teal>Splits a two-channel stack and only keeps channel 1 (called green in the menu based on frequency of use). <br><u>This option should only be performed once on a stack.</u>"
		+"<h4><font color=orange>Extract red channel only</h4>"
		+"<font color=teal>Splits a two-channel stack and only keeps channel 2 (called red in the menu based on frequency of use). <br><u>This option should only be performed once on a stack.</u>"
		+"<h4><font color=orange>Undo all</h4>"
		+"<font color=teal>Reverses all prior stack adjustments."
		+"<h4><font color=orange>None</h4>"
		+"<font color=teal>Does not alter the channel set-ups. This should be selected if you want to re-visit this menu to toggle any of the below options on and off."
		+"<h4><font color=orange>Make image a negative?</h4>"
		+"<font color=teal>This will invert the colors (dark colors become light and light colors become dark). <br>For example: yellow on a black background will become blue on a white background"
		+"<h4><font color=orange>Smooth image?</h4>"
		+"<font color=teal>Uses a 4X recursive correction/prediction algorithm to filter and \"smooth\" the stack by decreasing high gain noise and increasing discernibility of faint profiles. This filter computes Kalman Gain and predicts variance of the next image with each iteration. Runs the \"Kalman Stack Filter\" plugin written in java (with acquisition noise 0.05 and bias 0.80) written by Christopher Philip Mauer (c)2003."
		+"<h4><font color=orange>Lighten image?</h4>"
		+"<font color=teal>Increases luminosity of image in an adapted manner: Makes the bright more bright while leaving the darkest parts minimally touched. If you need to run this more than once, make sure \"None.\" on the above choices is selected."
		+"<h4><font color=orange>Darken image?</h4>"
		+"<font color=teal>Decreases luminosity of image in an adapted manner: Makes the darkest parts of the image darker, while leaving the lightest parts relatively untouched. If you need to run this more than once, make sure \"None.\" on the above choices is selected."
		+"<h4><font color=orange>Draw counting frame for 100X</h4>"
		+"<font color=teal>Draws a single counting frame that covers 70-71 % of the canvas."
		+"<br><br><font color=white>\<\<scroll up\>\>"
		
	//help region outline
	helpRegionOutline = "<html>"
		+"<h1><font color=fuchsia>Step 2. Region Outline</h1>"
		+"<b><font color=fuchsia>1. </b><font color=gray> You must draw an outline around your region to confine the counting to a specific territory. This is done both for speed and accuracy.<br><br>"
		+"<b><font color=fuchsia>2. </b><font color=gray> The area (in square micrometers) for the outline will automatically be calculated when you move to <font color=fuchsia>Step 3.<br><br>"
		+"<b><font color=fuchsia>3. </b><font color=gray> Clicking <font color=fuchsia> OK<font color=gray> on the <font color=fuchsia>Step 2 <font color=gray>box will duplicate the stack and name the duplicate <font color=fuchsia>reference<font color=gray>.<br><b><u>Importantly, many future operations rely on this new stack named reference and the metainformation associated with it.</u></b><font color=gray> If you close the stack or alter the name and/or metainformation, you may receive error messages later in the process.<br><br>"
		+"<b><font color=fuchsia>4. </b><font color=gray> The color for the region outline should be selected based on visibility.<br><br>"
		+"<b><font color=fuchsia>5. </b><font color=gray> How you define the region outline is up to you. Initially you will rely heavily on an atlas. As you count, you may find your definition changes. The important principle is consistency. <br><i>For example: If you notice you are going an inch (on your computer monitor) outside of a densely fibered territory on some subjects because there are neurons there, then consistently draw the region an inch around this densely fibered territory on all subjects.</i><br><br>"
		+"<br><hr><br><h2><font color=black>Usage:</h2>"
		+"1.  <u>Left-click</u> on a location at the region perimeter to start the outline (fully release the mouse button). <br><i>You will see a dot placed.</i><br><br>"
		+"2.  Move the mouse to another place along the region perimeter and <u>left-click</u> to place another dot. <br><i>You will see a line from the first dot to the second.</i><br><br>"
		+"3.  Continue to place dots as in Step 2.<br><i>You will see a line from the previous dot placed to where the mouse pointer is, as you move the mouse and left-click.</i><br><br>"
		+"4.  To end the region outline, you can connect the final dot to the first by <u>left-clicking</u> on the first dot. Alternately, you can <u>right-click</u> at any time to end the region outline.<br><i>You will see a completed polygon.</i><br><br>"
		+"•  After the region outline is completed, if you <u>left-click</u> somewhere outside the polygon you may experience it disappearing. If this happens you can try holding down <u>Ctrl + Shift and pressing 'E'</u>. If this does not bring the polygon back, you will have to re-draw it."
		+"<br><br><font color=white>\<\<scroll up\>\>"	
	
	//html sampling fraction
	helpSamplingFraction = "<html>"
		+"<h1><font color=#dc143c>Step 3 Counting Frame</h1>"
		+"<h4><font color=#dc143c>Sampling Fraction</h4>"
		+"<font color=black>This will set a fraction of the region to be counted. Below is a table that shows conversions from the selection values on the slider to percentage of area counted."
		+"<br><blockquote><font color=black>The sampling fraction represents the percentage of area covered by the <b><font color=blue>counting frame</b> <font color=black>(<b><font color=blue>blue</b> <font color=black>area in the diagram) within an unseen <b>grid</b> (<b>black</b> lines in the diagram) (See \"Help > Definitions\" for more information."
		+"<br><font color=white>````<font color=black>|<font color=white>````````````````````` <font color=black>|<font color=white>```"
		+"<br><font color=black> _ _ _|<font color=blue>______ <font color=black>_ _ _ _ _ _ _ _ _ _ |<font color=blue>__"
		+"<br><font color=white>````<font color=blue>|CFCFCF|<font color=white>```````````````<font color=blue>|CF"
		+"<br><font color=white>````<font color=blue>|CFCFCF|<font color=white>```````````````<font color=blue>|CF"
		+"<br><font color=white>````<font color=blue>|CFCFCF|<font color=white>```````````````<font color=blue>|CF"
		+"<br><font color=white>````<font color=blue>|______|<font color=white>```````````````<font color=blue>|__"
		+"<br><font color=white>````<font color=black>|<font color=white>````````````````````` <font color=black>|<font color=white>```"	
		+"<br><font color=white>````<font color=black>|<font color=white>````````````````````` <font color=black>|<font color=white>```"
		+"<br><font color=white>````<font color=black>|<font color=white>````````````````````` <font color=black>|<font color=white>```"
		+"<br><font color=white>````<font color=black>|<font color=white>````````````````````` <font color=black>|<font color=white>```"
		+"<br><font color=black> _ _ _|<font color=blue>______ <font color=black>_ _ _ _ _ _ _ _ _ _ |<font color=blue>__"
		+"<br><font color=white>````<font color=blue>|CFCFCF|<font color=white>```````````````<font color=blue>|CF"
		+"<br><font color=white>````<font color=blue>|CFCFCF|<font color=white>```````````````<font color=blue>|CF</blockquote>"
		+"<h4><font color=#dc143c>Counting Frame Size</h4>"
		+"<font color=black>A general rule for the <font color=#daa520>counting frame<font color=black> size is <font color=#daa520>10 ×<font color=black> the largest examples of the profile you are interested in counting. However, if the territory you are counting within is not densely populated, you may decide a larger <font color=#daa520>counting frame<font color=black> is desirable."
		+"<h4><font color=#dc143c>Use black/gray for the counting frame</h4>"
		+"<font color=black>Changes the default red/green <font color=#daa520>counting frame<font color=black> to a grayscale where the exclusion lines are thicker + darker and the inclusion lines are thinner + lighter."
		+"<h4><font color=#dc143c>Apply a random shade to the counting frame</h4>"
		+"<font color=black>Adjusts the red/green or black/gray <font color=#daa520>counting frame<font color=black> to random shades along the respective color scale. Prevents eye fatigue and helps distinguish different loci. If you are using the highest two sampling fractions, you may find it helpful to apply a random shade.<br><br>"
		+"<br><br><font color=white>\<\<scroll up\>\>"
		+"<br><hr><br><h2><font color=black>Sampling Fractions Table</h2>"
		+"<table>"
			+"<tr><th><u><font color=black>Selection number</u></th>"
				+"<th><u><font color=blue>Percent sampled</u></th>"
				+"<th><u><font color=green>Multiplication fraction</u></th></tr>"
			+"<tr><td>20</td> <td><font color=blue>100.0 %</td><td><font color=green>× 1/1</td></tr>"
			+"<tr><td>19</td> <td><font color=blue>66.7 %</td><td><font color=green>× 3/2</td></tr>"
			+"<tr><td>18</td> <td><font color=blue>50.0 %</td><td><font color=green>× 2/1</td></tr>"
			+"<tr><td>17</td> <td><font color=blue>41.5 %</td><td><font color=green>× 200/83</td></tr>"
			+"<tr><td>16</td> <td><font color=blue>33.3 %</td><td><font color=green>× 3/1</td></tr>"
			+"<tr><td>15</td> <td><font color=blue>25.0 %</td><td><font color=green>× 4/1</td></tr>"		
			+"<tr><td>14</td> <td><font color=blue>20.0 %</td><td><font color=green>× 5/1</td></tr>"
			+"<tr><td>13</td> <td><font color=blue>17.0 %</td><td><font color=green>× 100/17</td></tr>"	
			+"<tr><td>12</td> <td><font color=blue>15.0 %</td><td><font color=green>× 20/3</td></tr>"
			+"<tr><td>11</td> <td><font color=blue>13.0 %</td><td><font color=green>× 100/13</td></tr>"
			+"<tr><td>10</td> <td><font color=blue>11.5 %</td><td><font color=green>× 200/23</td></tr>"
			+"<tr><td>9</td> <td><font color=blue>10.0 %</td><td><font color=green>× 10/1</td></tr>"		
			+"<tr><td>8</td> <td><font color=blue>9.0 %</td><td><font color=green>× 100/9</td></tr>"
			+"<tr><td>7</td> <td><font color=blue>8.3 %</td><td><font color=green>× 12/1</td></tr>"
			+"<tr><td>6</td> <td><font color=blue>7.7 %</td><td><font color=green>× 13/1</td></tr>"
			+"<tr><td>5</td> <td><font color=blue>7.0 %</td><td><font color=green>× 100/7</td></tr>"
			+"<tr><td>4</td> <td><font color=blue>6.7 %</td><td><font color=green>× 15/1</td></tr>"
			+"<tr><td>3</td> <td><font color=blue>6.0 %</td><td><font color=green>× 50/3</td></tr>"		
			+"<tr><td>2</td> <td><font color=blue>5.6 %</td><td><font color=green>× 18/1</td></tr>"
			+"<tr><td>1</td> <td><font color=blue>5.0 %</td><td><font color=green>× 20/1</td></tr>"
		+"</table>"
		+"<br><br><font color=white>\<\<scroll up\>\>"

	//html counting frame usage
	helpCountingFrameUsage = "<html>"
		+"<h1><font color=black>Counting Frame</h1>"
		+"<font color=black>The <b><font color=red>red</b> <font color=black>and <b><font color=green>green</b> <font color=black>box overlayed on the z-stack is the <b>COUNTING FRAME</b>.<br>"
		//<!--1-->
		+"<h3><font color=teal>Counting Frame Usage:</h3>"
		+"<ul>"
			+"<b><span>&#8883;</span></b> If your profile is <b>ON</b> or touching a <b><font color=green>GREEN</b> <font color=black> line -- <b>COUNT</b> it<br>"
			+"<b><span>&#8883;</span></b> If your profile is <b>IN</b> the box -- <b>COUNT</b> it<br>"
			+"<b><span>&#8882;</span></b> If your profile is <b>ON</b> or touching a <b><font color=red>RED</b> <font color=black> line -- do <b>NOT</b> count it<br>"
			+"<b><span>&#8882;</span></b> If your profile is <b>OUT</b> of the box -- do <b>NOT</b> count it<br>"
			+"<b><span>&#8882;</span></b> If your profile is <b>ON</b> a <b><font color=green>GREEN</b> <font color=black> line AND a <b><font color=red>RED</b> <font color=black>line -- do <b>NOT</b> count it<br><br>"
		+"</ul>"
		//<!--2-->
		+"<h3><font color=teal>Choosing what to count:</h3>"
		+"<font color=black>You must decide what will qualify as the profile for your object of interest (neuron, cell, mitochondrion, synapse) when you are examining your images/stacks. This is determined largely operationally, meaning, as you go along. To start, below are some examples of what you may choose to initially qualify for a neuron profile."
		+"<ol>"
			//<!--2A-->
			+"<li><b><font color=orange>100X (oil)</b>"
			+"<ul>"
				+"<b><span>&#8901;</span></b><font color=black>nucleus center</br>"
				+"<b><span>&#8901;</span></b>penumbra of nucleus<br>"
				+"<b><span>&#8901;</span></b>axon hillock<br>"
				+"<b><span>&#8901;</span></b>outer edge of perikaryon<br>"
			+"</ul>"
			+"When <b>ONE</b> of these is in focus (the \"best\" focus), you will place a marker. (Only use <b>one</b> criterion and select this based on the immunolabel or stain you applied and what the neurons look like in your sections. <b><u> Do NOT change this profile criterion mid-study. If you decide there is a better option, you must redo everything using the new criterion.</b></u>)<br><br>"
			//<!--2B-->
			+"<li><b><font color=orange>10X (air)</b><br>"
			+"<ul>"
				+"<b><span>&#8901;</span></b><font color=black>dense labeling<br>"
				+"<b><span>&#8901;</span></b>any labeling<br>"
				+"<b><span>&#8901;</span></b>dual labeling only<br>"
			+"</ul>"
		+"</ol>"
		+"As you progress, this definition may change. You want to redo the first 10 subjects randomly throughout the counting process. If time permits, you may want to do each subject 3 times in a stratified random distribution across tertile or quartile temporal grouping of your study. Whether to average the repeats or to take the most recent, is up to you. I usually use the most recent only and just scrap the earlier counts as training sessions (same as in machine learning---you must optimize the human detection system)."
	
	//html help size
	helpSize = "<html>"
		+"<h1><font color=#000093>Size measurement techniques</h1>"
		+"<font color=#5c5c5c>Various techniques for measuring size (in area and volume) for nonspherical and spherical shapes, as well as thickness (in length) for elongated filamentous shapes are provided below. Some of the techniques require a clearly defined outline of the profile for accuracy. Color-coded blocks follow the name of the technique for a quick access reference on technique suitability (further elucidated under \"Design\" for each technique).<br> <font color=black>Shape: <b><font color=#009300><span>&#8718;</span> irregular <font color=#ff9224><span>&#8718;</span> spherical <font color=#9224ff><span>&#8718;</span> filamentous <font color=white><span>&#8718;</span> </b><font color=black>Clearly defined boundary: <b><font color=#009393><span>&#8718;</span> required <font color=#db0000><span>&#8718;</span> not required </b><br><br>"
		
		+"<h3><font color=#006edb>Cavalieri <font color=white><span>&#8718;</span> <font color=#009300><span>&#8718;</span><font color=#ff9224><span>&#8718;</span><font color=white><span>&#8718;</span> <font color=white><span>&#8718;</span> <font color=#009393><span>&#8718;</span><font color=#db0000><span>&#8718;</span></h3>"
		+"<font color=#black><u>Design:</u>  <font color=#5c5c5c>for <font color=#009300><b>irregular</b><font color=#5c5c5c> (nonspherical) or <b><font color=#ff9224>spherical</b><font color=#5c5c5c> shapes <font color=#009393><b>with</b> <font color=#5c5c5c>or <font color=#db0000><b>without</b><font color=#5c5c5c> a clearly defined boundary<font color=#5c5c5c><br>"
		+"<font color=#black><u>Output:</u>  <font color=#5c5c5c>area, square micrometers<br>"
		+"<font color=#black><u>Usage:</u>  <font color=#5c5c5c>A series of crosses (plus signs) will appear on the z stack. Bring the profile into focus and place markers on top of any cross that overlays the profile. Do not consider any area outside the small cross; if the cross overlays the profile, place a marker on top.<br>"
		+"<font color=#black><u>Calculation:</u>  <font color=#5c5c5c>Area contained within one tetrad of crosses is multiplied by number of markers placed.<br><br>"
		
		+"<h3><font color=#006edb>Nucleator <font color=white><span>&#8718;</span> <font color=white><span>&#8718;</span><font color=#ff9224><span>&#8718;</span><font color=white><span>&#8718;</span> <font color=white><span>&#8718;</span> <font color=#009393><span>&#8718;</span><font color=white><span>&#8718;</span></h3>"
		+"<font color=#black><u>Design:</u>  <font color=#5c5c5c>for <b><font color=#ff9224>spherical</b><font color=#5c5c5c> shapes <font color=#009393><b>with</b><font color=#5c5c5c> a clearly defined boundary<font color=#5c5c5c><br>"
		+"<font color=#black><u>Output:</u>  <font color=#5c5c5c>area, square micrometers, or volume, cubed micrometers<br>"
		+"<font color=#black><u>Usage:</u>  <font color=#5c5c5c>The user brings the profile into focus, and places a pivot marker in the center of the profile. 5 rays protruding from the pivot at 72-degree angles equidistant from each other will appear overlayed on the profile. The user then places markers on the rays at the location where they cross the boundary of the profile.<br>"
		+"<font color=#black><u>Calculation:</u>  <font color=#5c5c5c>A mean average radius is calculated based on the rays demarcated by user. The area or volume is then calculated using an assumption of a circle or spherical shape.<br><br>"
		
		+"<h3><font color=#006edb>Planimetry <font color=white><span>&#8718;</span> <font color=#009300><span>&#8718;</span><font color=#ff9224><span>&#8718;</span><font color=white><span>&#8718;</span> <font color=white><span>&#8718;</span> <font color=#009393><span>&#8718;</span><font color=white><span>&#8718;</span></h3>"
		+"<font color=#black><u>Design:</u>  <font color=#5c5c5c>for <font color=#009300><b>irregular</b><font color=#5c5c5c> (nonspherical) or <b><font color=#ff9224>spherical</b><font color=#5c5c5c> shapes <font color=#009393><b>with</b><font color=#5c5c5c> a clearly defined boundary<font color=#5c5c5c><br>"
		+"<font color=#black><u>Output:</u>  <font color=#5c5c5c>area, square micrometers<br>"
		+"<font color=#black><u>Usage:</u>  <font color=#5c5c5c>Draw a line around the perimeter of the profile. Left-click anywhere on the perimeter to place the first dot. Move to a second location along the perimeter, and left-click; this will place a second dot. Continue placing dots along the perimeter of the profile being measured until an outline is traced.<br>"
		+"<font color=#black><u>Calculation:</u>  <font color=#5c5c5c>The area of the object is calculated using geometric principles for measuring surface area (two dimensional object) of a polygon.<br><br>"
		
		+"<h3><font color=#006edb>Thickness <font color=white><span>&#8718;</span> <font color=white><span>&#8718;</span><font color=white><span>&#8718;</span><font color=#9224ff><span>&#8718;</span> <font color=white><span>&#8718;</span> <font color=#009393><span>&#8718;</span><font color=white><span>&#8718;</span></h3>"
		+"<font color=#black><u>Design:</u>  <font color=#5c5c5c>for <font color=#9224ff><b>elongated, filamentous</b> <font color=#5c5c5c>shapes <font color=#009393><b>with</b><font color=#5c5c5c> a clearly defined boundary<font color=#5c5c5c><br>"
		+"<font color=#black><u>Output:</u>  <font color=#5c5c5c>length, micrometers<br>"
		+"<font color=#black><u>Usage:</u> <font color=#5c5c5c>An axis through the longest part of the profile is aligned by the user. The user then clicks on the the end limits of the profile that are perpendicular to the this axis. A series of three lines is then populated and the user places markers at the locations where the markers cross the boundary of the profile.<br>"
		+"<font color=#black><u>Calculation:</u>  <font color=#5c5c5c>A mean average length based on the three measurements is calculated.<br><br>"
	
	//html known bugs
	helpKnownBugs = "<html>"
		+"<h1><font color=#006edb>Known Bugs</h1>"
		+"<font color=#00386f>The following are known bugs with the program. Use caution." 
		+"<dl>"
		+"<dt><h3><font color=#ff4848>Missing counts in subtotal.</h3></dt>"
		+"<dd><font color=black><tt><u>SCENARIO:</u> User counts using <font color=#daa520><b>marker a</b><font color=black>, then runs <b><i>(Saves Counts)</i></b> from the right-click menu and selects a new marker, <font color=#00b700><b>marker b</b><font color=black>. User counts with <font color=#00b700><b>marker b</b><font color=black>, but while using <font color=#00b700><b>marker b</b><font color=black>, user sees a profile missed when counting with <font color=#daa520><b>marker a</b><font color=black>. User runs <b><i>(Saves Counts)</i></b> from the right-click menu to log all <font color=#00b700><b>marker b</b><font color=black> placements and returns to marker selection. User reselects <font color=#daa520><b>marker a</b><font color=black> and counts the missed profile with <font color=#daa520><b>marker a</b><font color=black> User finishes, and selects <b><i>Step 5. Next</i></b> from the right-click menu. </tt></dd>"
		+"<font color=#00386f><b><u>The problem:</b></u> Everything in the <b><i>Log</i></b> is correct until the user runs <b><i>Step 6. Get Results</i></b>. As the program subtotals, <font color=#ff4848><b><u>it only counts the first occurrence of each marker at each location.</u></b><font color=#00386f> Thus, the subtotal will miss the second and any subsequent counts for a marker already logged at a specific location.<br>"
		+"<font color=#00386f><b><u>Manual fix:</b></u> The user will have to subtotal markers counted more than once at a single location.<br><br>"
		+"<dl>"
		+"<dt><h3><font color=#ff4848>Automatic marker placed.</h3></dt>"
		+"<dd><font color=black><tt><u>SCENARIO:</u> User counts using <font color=#daa520><b>marker a</b><font color=black>, then runs <b><i>(Saves Counts)</i></b> from the right-click menu and selects a new marker, <font color=#00b700><b>marker b</b><font color=black>. The program automatically places one <font color=#00b700><b>marker b</b><font color=black> over the last placed <font color=#daa520><b>marker a</b><font color=black>.</tt></dd>"
		+"<font color=#00386f><b><u>The problem:</b></u> Despite attempts to prevent this, the program sometimes automatically places a marker directly on top of a different marker. This will skew results +1 if not corrected.<br>"
			+"<font color=#00386f><b><u>Manual fix:</b></u> The user will have to left click on the wrong marker while holding down the Ctrl key on the keyboard. This will delete the incorrect automatic marker.<br><br>"
			
		+"<br><br><font color=white>\<\<scroll up\>\>"
		
	//html Coansi about
	helpCoansiAbout = "<html>"
		+"<h2><tt><font color=black>About Coansi</tt></h2><br>"
		+"<tt><font color=black><b>Coansi</b> \\kohn-see\\ stands for <font color=blue><b><u>Co</u><font color=black>unts <font color=blue><u>an</u><font color=black>d <font color=blue><u>si</u><font color=black>ze</b><font color=black>. It is designed to be a desktop alternative to counting microscopic objects and performing morphometric assessment at the microscope. <b>Coansi</b> allows the user to perform measurements on any computer that has enough RAM to open a z-stack. This limits the amount of exposure to fluorescence preparations and the burden on time-shared equipment.<br><br>"
		+"The program was built using a java macro language on the ImageJ 1.52a source code [release April 2018] and Zeiss 10X (1 micron : 1.4 pixels) and 100X (1 micron : 11.4 pixels) z-stacks. <b>Coansi</b> comprises a mix of known stereology tools and custom probes based on mathematical theory and classic geometric principles. All probes should be user tested by someone with a full understanding of stereological theory. A program is not substitute for knowledge but a tool to implement knowledge.<br><br>"
		+"<b>Coansi</b> was conceived of and designed by Christy M. Kelley while working in the laboratory of Elliott J. Mufson; it was designed for Megan K. Gautier while working in the laboratory of Stephen D. Ginsberg. It was written 2019-2020.<br></tt>"

	
	//java macro
	Dialog.create("Help");
	Dialog.addRadioButtonGroup("Help",newArray(
		"Definitions",
		"General Problems",
		"Step 1. Stack Preparation",
		"Step 2. Region Outline",
		"Step 3. Sampling",
		"Step 4. Markers",
		"Step 5. Counting Frame Guidelines",
		"Step 2. Size Measurements",
		"Step 3. Markers",
		"Known Bugs",
		"About Coansi"),15,1,RBG_helpMenu);
	Dialog.show();
	
	helpMenu = Dialog.getRadioButton

	if(helpMenu == "Definitions"){
		showMessage(helpDefinitions);
	} if(helpMenu == "General Problems"){
		showMessage(helpGeneralProblems);
	} if(helpMenu == "Step 1. Stack Preparation"){
		showMessage(helpImagePrep);
	} if(helpMenu == "Step 2. Region Outline"){
		showMessage(helpRegionOutline);
	} if(helpMenu == "Step 3. Sampling"){
		showMessage(helpSamplingFraction);
	} if(helpMenu == "Step 4. Markers"){
		showMessage(helpPointTool);
	} if(helpMenu == "Step 5. Counting Frame Guidelines"){
		showMessage(helpCountingFrame);
	} if(helpMenu == "Step 2. Size Measurements"){
		showMessage(helpSize);
	} if(helpMenu == "Step 3. Markers"){
		showMessage(helpPointTool);
	} if(helpMenu == "Known Bugs"){
		showMessage(helpKnownBugs);
	} if(helpMenu == "About Coansi"){
		showMessage(helpCoansiAbout);
	}
}

//java macro
macro "countingWorkflowMessage" {
	showMessage("Coansi  |  Counting Workflow","Use the steps in the right-click menu to complete the counting workflow.");
}

//java macro
macro "sizeMeasurementsMessage" {
	showMessage("Coansi  |  Size Measurements","Use the steps in the right-click menu to choose a tool for size measurements.");
}

//java macro							pmcmd
macro "scratchPad" {
	run("Text Window");
}

//java macro							pmcmd
macro "snapshot" {
	run("Capture Image");
}

//java macro							pmcmd
macro "screenShot" {
	run("Capture Delayed...", "delay=1");
}

//macro artistic effects
macro "artisticEffects" {
	Dialog.create("Coansi  |  Artistic effects");
	Dialog.addRadioButtonGroup("Select an effect:", newArray(
		"rainy window",
		"pin art  (line plot)",
		"ocean  (line plot)",
		"EEG  (line plot)",
		"puncta",
		"princess",
		"droplets",
		"post-its",
		"windshield",
		"stucco",
		"thermal  (flat)",
		"fractal  (flat)",
		"ghost  (flat)",
		"layered mosaic  (slow)",
		"80s rad  (slow)",
		"mountains  (slow)",
		"none"),9,2,RBG_effect1);
	Dialog.setInsets(0,-5,0);
	Dialog.addMessage("These effects were optimized using flattened dual channel stacks.");
	Dialog.show();
	
		
	effect1 = Dialog.getRadioButton;


	run("Duplicate...", "duplicate");
	rename("tempAE");
	if (effect1 == "rainy window") {						//rainy window
		rename("rainy window");
		run("Subtract Background...", "rolling=100 light separate create sliding stack");
	} 
	if (effect1 == "pin art  (line plot)") {								//surface plot skeleton
		run("32-bit");
		run("Surface Plot...", "polygon=150 draw_wireframe draw_axis stack");
		rename("pin art");
	} 
	if (effect1 == "ocean  (line plot)") {								//surface plot skeleton smooth
		run("32-bit");
		run("Surface Plot...", "polygon=150 draw_wireframe draw_axis smooth stack");
		rename("ocean");
	} 
	if (effect1 == "EEG  (line plot)") {									//surface plot skeleton smooth
		run("32-bit");	
		run("Surface Plot...", "polygon=15 draw_wireframe draw_axis smooth stack");
		rename("EEG");
	} 
	if (effect1 == "puncta") {								//5 ramps
		run("32-bit");	
		run("5 Ramps");
		rename("puncta");
	} 
	if (effect1 == "princess") {							//ice
		run("Enhance Contrast...", "saturated=0.15 process_all");
		run("32-bit");	
		run("Ice");
		rename("princess");
	}
	if (effect1 == "droplets") {							//surface plot cool
		run("32-bit");
		run("Smooth", "stack");
		run("Surface Plot...", "polygon=100 shade fill stack");
		run("Cool");
		rename("droplets");
	} 
	if (effect1 == "post-its") {							//
		rename("post-its");
		run("Subtract Background...", "rolling=50 light separate create disable stack");
	} 
	if (effect1 == "windshield") {							//variance
		rename("windshield");
		run("Variance...", "radius=20 stack");
	}
	if (effect1 == "stucco") {								//shadow
		rename("stucco");
		run("Southeast", "stack");
	} 
	if (effect1 == "thermal  (flat)") {								//
		rename("thermal");
		run("Z Project...", "projection=[Average Intensity]");
		run("32-bit");
		run("Cool");
	} 
	if (effect1 == "fractal  (flat)") {								//
		run("RGB Color");
		run("Z Project...", "projection=[Max Intensity]");
		run("Brightness/Contrast...");
		setMinAndMax(55, 305);
		run("Apply LUT", "stack");
		selectWindow("B&C");
		run("Close");
		run("Subtract Background...", "rolling=5 light sliding disable");
		rename("fractal");
	} 
	if (effect1 == "ghost  (flat)") {								//
		run("RGB Color");
		run("Z Project...", "projection=[Sum Slices]");
		run("Brightness/Contrast...");
		setMinAndMax(55, 305);
		run("Apply LUT", "stack");
		selectWindow("B&C");
		run("Close");
		run("Subtract Background...", "rolling=5 light sliding disable");
		rename("ghost");
	} 
	if (effect1 == "layered mosaic  (slow)") {								//
		rename("layered mosaic");
		run("Subtract Background...", "rolling=10 light separate create disable stack");
	}
	if (effect1 == "80s rad  (slow)") {						//
		rename("80s rad");
		run("Subtract Background...", "rolling=10 light separate create disable stack");
		run("32-bit");
		run("Find Edges", "stack");
		run("16 Colors");		
	} 
	if (effect1 == "mountains  (slow)") {
		run("Subtract Background...", "rolling=10 light separate create sliding disable stack");
		run("32-bit");
		run("Surface Plot...", "polygon=150 shade fill smooth stack");
		run("Smart");
		rename("mountains");
	}
	if (isOpen("tempAE")) {
		selectWindow("tempAE");
		close();
	}
}

//macro java
macro "stackStatistics" {
	Dialog.create("Coansi  |  Stack statistics");
	Dialog.addRadioButtonGroup("Select a procedure:", newArray(
		"average through z",
		"maximum through z",
		"minimum through z",
		"sum through z  (cmk favorite)",
		"penetrance graph",
		"show profiles through z (z,y)",
		"show profiles through z (x,z)",
		"collapse stack",
		"none"),9,1,"none");
	Dialog.show();
	
		
	effect2 = Dialog.getRadioButton;
		
	//slice interval for z views
	meta = getImageInfo();
	indexZ1 = lastIndexOf(meta,"Depth:")+7;
	indexZ2a = indexOf(meta,getInfo("micrometer.abbreviation"),indexZ1)+4;
	indexZ2b = indexOf(meta,")",indexZ2a);
	depthSz = 1;
	stackSz = 1;
	if(indexZ1 <indexZ2a){
		depthSz = parseFloat(substring(meta, indexZ1, indexZ2a));
		stackSz = parseFloat(substring(meta, indexZ2a, indexZ2b));
	}
	sliceI = parseFloat(depthSz/stackSz);
	
	//need to change scale pixels to micrometers to work on all images


	if (effect2 == "average through z") {								//stack-to-image
		run("Z Project...", "projection=[Average Intensity]");
	} 
	if (effect2 == "maximum through z") {								//stack-to-image
		run("Z Project...", "projection=[Max Intensity]");
	} 
	if (effect2 == "minimum through z") {								//stack-to-image
		run("Z Project...", "projection=[Min Intensity]");
	} 
	if (effect2 == "sum through z  (cmk favorite)") {					//stack-to-image
		run("Z Project...", "projection=[Sum Slices]");
	} 
	if (effect2 == "penetrance graph") {								//stack-to-image
		run("Plot Z-axis Profile");
		plot1 = getTitle();
		selectWindow(plot1);
		Plot.makeHighResolution(plot1,4.0);
		plot2 = getTitle();
		selectWindow(plot1);
		getLocationAndSize(x, y, width, height);
		close();
		setLocation(x,y);
	} 
	if (effect2 == "show profiles through z (z,y)") {					//stack-to-image
		run("3D Project...", "projection=[Brightest Point] axis=Y-Axis slice=sliceI initial=90 total=0 rotation=10 lower=1 upper=255 opacity=0 surface=100 interior=50 interpolate");
		if(indexZ1 <indexZ2a){
			run("Set Scale...", "distance=1 known=1 pixel=1 unit=µm");
		}
		run("Scale Bar...", "width=100 height=5 font=18 color=White background=None location=[Lower Right] bold");
	}
	if (effect2 == "show profiles through z (x,z)") {							//
		run("3D Project...", "projection=[Brightest Point] axis=X-Axis slice=sliceI initial=90 total=0 rotation=10 lower=1 upper=255 opacity=0 surface=100 interior=50 interpolate");
		//run("Scale Bar...", "width=100 height=5 font=18 color=White background=None location=[Lower Right] bold");
	} 
	if (effect2 == "collapse stack") {							//
		run("3D Project...", "projection=[Brightest Point] axis=Z-Axis slice=sliceI initial=90 total=0 rotation=10 lower=1 upper=255 opacity=0 surface=100 interior=50 interpolate");
		run("Rotate 90 Degrees Left");
	} 
}

//java macro							pmcmd
macro "closeAll" {
	Dialog.create("Do you want to close all pop-up windows?");
	Dialog.addCheckbox("Close all zoomed windows",CB_c1);
	//Dialog.addCheckbox("Reset zoomed windows",CB_c2);
	Dialog.addCheckbox("Close all image windows and z-stacks except the front window",CB_c3);
	//Dialog.addCheckbox("Close all text windows",CB_c4);
	Dialog.addCheckbox("Close all image windows and z-stacks",CB_c5);
	Dialog.show();
	
	c1 = Dialog.getCheckbox;
	//c2 = Dialog.getCheckbox;
	c3 = Dialog.getCheckbox;
	//c4 = Dialog.getCheckbox;				close("*.txt");
	c5 = Dialog.getCheckbox;
	
	
	if (c1 == true) {			//closes zoomed counting frame images
		close("* of *");		
	} if (c3 == true) {			//close all image windows but front
		close("\\Others");		
	} if (c5 == true) {			//close image windows
		close("*");		
	}
}


//pmcmds								pmcmd
var pmCmds = newMenu("Popup Menu", newArray(
		"Step 1. Stack Preparation...",
		"-",
		"COUNTING WORKFLOW",
		"Step 2. Region Outline...",
		"Step 3. Sampling...", 
		"Step 4. Markers...",
		"Step 5. Next",
		"(Save Counts)",
		"Step 6. Get Results",
		"-",
		"SIZE MEASUREMENTS",
		"Step 2. Choose a tool...",
		"Step 3. Markers",
		"Step 4. Get Size Measurement",
		"-",
		"Help...",
		"-",
		"Scratch Pad",
		"Snapshot of Image",
		"Capture Screen",
		"Artistic Effects",
		"Stack Statistics",
		"-",
		"Close All")
		);


macro "Popup Menu" {
	cmd = getArgument();
	if (cmd == "Step 1. Stack Preparation...")
		run("imagePrep");
	if (cmd == "COUNTING WORKFLOW")
		run("countingWorkflowMessage");
	if (cmd == "Step 2. Region Outline...")
		run("selectRegion");
	if (cmd == "Step 3. Sampling...")
		run("sampling");
	if (cmd == "Step 4. Markers...")
		run("markers");
	if (cmd == "Step 5. Next")
		run("next");
	if (cmd == "(Save Counts)")
		run("lockMarkers");
	if (cmd == "Step 6. Get Results")
		run("resultsCounts");
	if (cmd == "SIZE MEASUREMENTS")
		run("sizeMeasurementsMessage");
	if (cmd == "Step 2. Choose a tool...")
		run("size");
	if (cmd == "Step 3. Markers")
		run("sizeMarkers");
	if (cmd == "Step 4. Get Size Measurement")
		run("sizeResults");
	if (cmd == "Help...")
		run("help");
	if (cmd == "Scratch pad")
		run("scratchPad");
	if (cmd == "Snapshot of Image")
		run("snapshot");
	if (cmd == "Capture Screen")
		run("screenShot");
	if (cmd == "Artistic Effects")
		run("artisticEffects");
	if (cmd == "Stack Statistics")
		run("stackStatistics");
	if (cmd == "Close All")
		run("closeAll");
}
