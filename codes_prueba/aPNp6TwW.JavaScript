function adventureSelector(userChoice) {
  return function(userChoise) {
    if (userChoise === 1) return "You selected the Vines of Doom!";
    else if (userChoise === 2) return "Looks like you want the Lake of Despair!";
    else if (userChoise === 3) return "The Caves of Catastrophe!";
  };
}