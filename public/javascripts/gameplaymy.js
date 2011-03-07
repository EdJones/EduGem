// Functions to respond to user-sorted events, display score and messages accordingly
//Check older version for additional methods, code, and test alerts--3/6/2011

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
//For testing: alert ("targetArray: " + targetArray);
var numC = 0;
var e1 = 0;
m2 =$('message2');
m3 =$('popup');
m4 =$('message4');

//For testing: alert($(element).innerHTML); Displays destination unordered list

// Find local event array id of the item just dropped.
droppedEventId = parseInt(lastDropped.idString.slice(10,13));

//Loop through target list to check which events are in order
var iterator=  function(value, index) {
   if ( index != 0) {
   prevTargetEventId = targetArray[(index-1)];
//Testing: alert ("index: " + index + "targetArray: " + targetArray);
   testedTargetEventId = targetArray[index];
//Testing: alert ("testedTargetEventId: " + testedTargetEventId);
//Testing: alert ("eventList[(testedTargetEventId)][custom_event].year: " + eventList[(testedTargetEventId)]["custom_event"].year);
       if ( eventList[(testedTargetEventId)]["custom_event"].year >= eventList[(prevTargetEventId)]["custom_event"].year){ 
	   	numC = (numC + 1); 

	   }
   };
 }

// When done iterating rack up the score.
targetArray.each(iterator);

dispCorrect = (numC-5);
dispAttempt = (targetArray.length-6);

d.innerHTML=dispCorrect+" / "+dispAttempt;
//Testing: alert("totalPoints: " + totalPoints + "eventList[droppedEventId]["custom_event"] : " + eventList[droppedEventId]["custom_event"].pointValue );
//Testing: alert( eventList[droppedEventId]["custom_event"].pointValue);
eventPoints = eventList[droppedEventId]["custom_event"].pointValue;
//And update user interface
if (dispCorrect  < last_correct) {totalPoints = totalPoints -  eventPoints; Sound.play("../sounds/sword.wav");m.innerHTML="Oops!";m2.innerHTML=(" ");flashMe("Oops!");};
if (dispCorrect  > last_correct) {totalPoints = totalPoints + eventPoints; Sound.play("../sounds/4arrow.wav");m.innerHTML="&nbsp";m2.innerHTML=("Good! It was " + BCize (eventList[droppedEventId]["custom_event"].year));flashMe("Good! It was " + BCize (eventList[droppedEventId]["custom_event"].year));};
if (dispCorrect  == last_correct) {totalPoints = (totalPoints - eventPoints /10) ; Sound.play("../sounds/8squish.wav");m.innerHTML="Nope!";m2.innerHTML=(" ");};
if (dispCorrect == 10) {Sound.play("../sounds/bike.wav");m4.style.display="block";};
if (dispCorrect == didjiLength) {Sound.play("../sounds/winner.wav");m.innerHTML="Sweet!!";l.style.display="block";m4.style.display="none";};
accumPoints = totalPoints + lastPoints;
p.innerHTML=accumPoints;
last_correct=dispCorrect;
};