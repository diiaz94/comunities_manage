


function marktext(t){

	var textsArr =$(".text-searched");
	
	$.each(textsArr,find_and_mark);
}

var find_and_mark = function (i,element){
		var ts=$(element).text();
		var index = find_indexes(ts);
		var result="";
		if(index!=-1){
			result = ts.substring(0,index)+"<b>"+ts.substring(index,index+text.length)+"</b>"+ts.substring(index+text.length)
			$(element).html(result);
		}
	};


function find_indexes(ts){

	var index;
	
	index=ts.indexOf(text);
	if(index!=-1){ 
		return index;
	}else{
		index=ts.indexOf(text.toUpperCase());
		if(index!=-1){
			return index;
		}else{
			index=ts.indexOf(text.toLowerCase());
			if(index!=-1){ 
				return index;
			}else{
				if(ts.length>1){
					index=ts.indexOf(text[0].toUpperCase()+text.substring(1));
					if (index!=-1) {
						return index;	
					}else{
						return -1;
					}
				}else{
					return -1;
				}
				
			}
		}

	}
}