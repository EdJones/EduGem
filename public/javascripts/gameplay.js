// Functions to respond to user-sorted events, display score and messages accordingly


//Initialize global variables
lastDropped = new Object();
lastDropped.idString = 1;
last_correct=0;
accumPoints=0;
totalPoints = 0;

//Function run from first sortable list's onChange callback.
var refresh = function(element) {
var m =$('message');
m.innerHTML ="&nbsp;";
};

//Used by compare function
//Function to write 2000BC or 2009AD
var BCize = function(year) {
if (year < 0) 
	{return (Math.abs(year) + " B.C.")}
else if (year < 1000 && year >= 0) {return (year + " C.E.")}
else {return (year)};
};

//Used by flashMe
function setToInvisible ( ) {
  m3.style.display=("none");
}
//Function to pop up success/miss message
var flashMe = function(someMessage) {
	m3.innerHTML=(someMessage);
	m3.style.display=("block");
  setTimeout ( "setToInvisible()", 1100 );


}



//Function run when destination list Updates (onUpdate callback). Iterates through list to check order
var compare = function(element) {
var d =$('displayCorrect');
p =$('displayPoints');
var apoints = 0;
var y =$('year');
var m =$('message');
var l = $('levelUp');
var points = 0;
//var totalPoints = 0;
var targetArray = Sortable.sequence('fourthlist',{name:name});
//alert ("targetArray: " + targetArray);
var numC = 0;
var e1 = 0;
m2 =$('message2');
m3 =$('popup');
m4 =$('message4');

//For testing: alert($(element).innerHTML); Displays destination unordered list

// Called inside iterator
// takes the idee of the event in the database and converts it to the id of the concatenated events array created by each view partial
var ideeToId = function(idee) {
	if (idee <= 5) {
		id = idee
		}
	else id = idee - (eventsStartIdee - 6);	

return (id);
};

// Find the database idee and the local event arrat id of the item just dropped.
droppedEventIdee = parseInt(lastDropped.idString.slice(10,13));
droppedEventId = ideeToId(droppedEventIdee);

//Loop through target list to check which events are in order
var iterator=  function(value, index) {
   if ( index != 0) {
   prevTargetEventId = ideeToId(targetArray[(index-1)]);
   testedTargetEventId = ideeToId(targetArray[index]);
       if ( eventList[(testedTargetEventId)]["event"].year >= eventList[(prevTargetEventId)]["event"].year){ 
	   	numC = (numC + 1); 

	   }
   };
 }

// When done iterating rack up the score.
targetArray.each(iterator);

dispCorrect = (numC-5);
dispAttempt = (targetArray.length-6);

d.innerHTML=dispCorrect+" / "+dispAttempt;
//alert("totalPoints: " + totalPoints + "eventList[droppedEventId]["event"] : " + eventList[droppedEventId]["event"].pointValue );
eventPoints = eventList[droppedEventId]["event"].pointValue;
//alert("totalPoints: " + totalPoints + "eventList[droppedEventId]["event"] : " + eventList[droppedEventId]["event"].pointValue );
if (dispCorrect  < last_correct) {totalPoints = totalPoints - eventPoints; Sound.play("../sounds/sword.wav");m.innerHTML="Oops!";m2.innerHTML=(" ");flashMe("Oops!");};
if (dispCorrect  > last_correct) {totalPoints = totalPoints + eventPoints; Sound.play("../sounds/4arrow.wav");m.innerHTML="&nbsp";m2.innerHTML=("Good! It was " + BCize (eventList[droppedEventId]["event"].year));flashMe("Good! It was " + BCize (eventList[droppedEventId]["event"].year));};
if (dispCorrect  == last_correct) {totalPoints = totalPoints- (eventPoints /10); Sound.play("../sounds/8squish.wav");m.innerHTML="Nope!";m2.innerHTML=(" ");};
if (dispCorrect == 10) {Sound.play("../sounds/bike.wav");m4.style.display="block";};
if (dispCorrect == 14) {Sound.play("../sounds/winner.wav");m.innerHTML="Sweet!!";l.style.display="block";m4.style.display="none";};
accumPoints = totalPoints + lastPoints;
p.innerHTML=accumPoints;
last_correct=dispCorrect;
};


// ************* Test stuff to toss or use later ***************

//Function run when sortable item is selected (display pic, etc).
//var pickOne = function(element) {
//alert("You picked one");
//};


//alert ( <%=  @events.to_json %>.attributes.evalJSON(true) );
// alert( jsondata );
// alert(json1[]);
// var json2 = eval('(' + json1[] + ')');
// alert (json2);


//var setTestState = function() {
//numListitems = 1;
//};


