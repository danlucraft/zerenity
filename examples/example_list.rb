require('zerenity/list')

choice = Zerenity::List(:columns=>["Food","Energy"],:data=>[["Chips","200KJ"],["Chocolate","300KJ"]])
choice ? puts("You chose #{choice[0]} which has #{choice[1]} of energy.") : puts("You didn't choose an item.") 

choice = Zerenity::List(:columns=>["Selected","Food","Energy"],:data=>[[true,"Chips","200KJ"],[false,"Chocolate","300KJ"],[false,"Pretzels","250KJ"]],:radiolist=>true)
choice ? puts("You chose #{choice[0]} which has #{choice[1]} of energy.") : puts("You didn't choose an item.") 

choices = Zerenity::List(:columns=>["Selected","Food","Energy"],:data=>[[true,"Chips","200KJ"],[false,"Chocolate","300KJ"],[false,"Pretzels","250KJ"]],:checklist=>true,:title=>"Please select snacks")
choices ? choices.each {|row| puts("You chose #{row[0]} which has #{row[1]} of energy.")} : puts("You did not choose any items") 
