<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="cafe.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&family=Noto+Sans+KR&family=Sunflower:wght@300&display=swap" rel="stylesheet">    <title>카페관리</title>
</head>

<body>
<h1 align=center>카페 관리</h1>
    <table align="center">
        <tr>
            <td valign=top>
                <table class='bound' id=mlist>
                    <caption>메뉴목록</caption>
                    <tr>
                        <td align="right" colspan=2>
                        <button id=btnMenu class='mm'>메뉴관리</button>
                    </td>
                    </tr>
                    <tr>
                        <td colspan=2>
                            <select id=selMenu size=13></select>
                        </td>
                    </tr>
                    <tr>
                        <td class='mm'>메뉴 코드</td>
                        <td><input type="text" id=menucode width=20% readonly></td>
                    </tr>
                    <tr>
                        <td class='mm'>메뉴명</td>
                        <td><input type="text" id=menuname readonly></td>
                    </tr>
                    <tr>
                        <td class='mm'>수량</td>
                        <td><input type="number" id=count min=1></td>
                    </tr>
                    <tr>
                        <td class='mm'>금액</td>
                        <td><input type="number" id=price readonly></td>
                    </tr>
                    <tr>
                        <td><button id=btnReset class='mm'>지우기</button></td>
                        <td align="right"><button id=btnAdd class='mm'>메뉴추가</button></td>
                    </tr>
                </table>
            </td>
            <td valign=top>
                <table class='bound'>
                    <caption id=capt1 class='mm'>주문목록</caption>
                    <tr>
                        <td colspan="2">
                            <select id=selOrder size=14></select>
                        </td>
                    </tr>
                    <tr>
                        <td class='mm'>총액</td>
                        <td><input type="number" id=total></td>
                    </tr>
                    <tr>
                        <td class='mm'>모바일</td>
                        <td><input type=phone id=mobile size=13></td>
                    </tr>
                    <tr>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td><button id=btnCancel class='mm'>주문취소</button></td>
                        <td align="right"><button id=btnDone class='mm'>주문완료</button></td>
                    </tr>
                </table>
            </td>
            <td valign=top>
                <table class='bound' >
                    <caption id=capt1 class='mm'>판매내역</caption>
                    <tr>
                        <td>
                            <select id=selSales size=17></select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button id=clean class='mm'>초기화</button>
                            <button id=summary class='mm'>Summary</button>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <div id=dlgMenu title='메뉴 관리' style="display: none">
       <table>
        <tr>
            <td>
                <select id=selMenu1 size=10></select>
            </td>
            <td>
                <table>
                <tr><td colspan=2 style=font-size:10px>코드만입력 : 메뉴 삭제<br>메뉴명,가격만 입력 : 메뉴 추가<br>코드,메뉴명,가격 전부 입력 : 메뉴 수정</td></tr>
                <tr>
                    <td>메뉴코드</td><td><input type=text id=_menucode style=width:120px></td>
                    <td rowspan=3 valign=middle>
                        <button id=btnGO>작성완료</button>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>메뉴명</td><td><input type=text id=_menuname style=width:120px></td>
                    
                </tr>
                <tr>
                    <td>단가(가격)</td><td><input type=number id=_price step=100 min=100 style=width:50px>원</td>
                </tr>
                
                    
                
                </table>
            </td>
        </tr>    
        </table>
    
    </div>
    <div id=dlgsummary title='총 판매량' style="display: none;" >
    	<table id=tbdlg>
    		<thead id=tbdlghead>
    			<tr>
    				<th align=left>메뉴별 매출금액(가나다순)<br>메뉴코드 / 메뉴명 / 수량 / 총가격</th>
    				<th colspan=3 align=left>고객번호별 매출금액(매출액순)<br>모바일 / 총가격</th>
    			</tr>
    		</thead>
			<tbody id=tbdlgbody>
    			<tr>
	    		    <td>
	                      <select id=selsummary size=13></select>
	                </td>
	            	<td>
	            		<table>
	    					
	    					<tr>
	    						<td colspan=4>
	    							<select id=sum_customer size=13 align=right></select>
	    						</td>
	    					</tr>
	    				</table>
	    			</td>
	            </tr>
	    	</table>


    </div>

</body>
<script src='https://code.jquery.com/jquery-3.5.0.js'></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
let total=0;
$(document)
.ready(function(){
	loadMenu();
	summary();
	return false;
})
.on('click','#btnMenu',function(){
	$('#dlgMenu').dialog({
        width: 800

        
    })
})
.on('click','#summary',function(){
	summary();
	sum_cus();
	$('#dlgsummary').dialog({
		
		width:800
		
	})})

.on('click','#selMenu1',function(){
	pr=$('#selMenu1 option:selected').text();
	ar=pr.split(' ');
	 $('#_menucode').val(ar[0]);
	 $('#_menuname').val(ar[1]);
	 $('#_price').val(ar[2]);
})
.on('click','#btnGO',function(){
	let operation='';
	if($('#_menucode').val()==''){
		if($('#_menuname').val()!='' && $('#_price').val()!=''){ //insert
			operation='insert';
		}else{
			alert('입력값이 모두 채워지지 않았습니다.');
			return false;
		}
	}else {
		if($('#_menuname').val()!='' && $('#_price').val()!=''){ 
			//update
			operation='update';
		}else{ //delete
			operation='delete';	
		}
	}
	
	$.get(operation,{name:$('#_menuname').val(),
				price:$('#_price').val(),
				code:$('#_menucode').val()},
			function(txt){
				$('#_menuname,#_price,#_menucode').val('');
				loadMenu();
			},'text');
return false;
})

.on('click','#selMenu',function(){
    Nm_Pr=$('#selMenu option:selected').text();
    ar=Nm_Pr.split(' ');
    $('#menucode').val(ar[0]);
   $('#menuname').val(ar[1]);
   $('#price').val(ar[2]);
   $('#count').val(1)
})
.on('change','#count',function(){
    C=0;
    Nm_Pr=$('#selMenu option:selected').text();
     ar=Nm_Pr.split(' ');
     parseInt(ar[2]);
    $('#price').val(ar[2]*$('#count').val());
})
.on('click','#btnReset',function(){
    $('#menuname,#count,#price,#menucode').val('');
})
.on('click','#btnAdd',function(){
	code=$('#menucode').val();
    M=$('#menuname').val();
    C=$('#count').val();
    P=$('#price').val();
    P=parseInt(P);
    strOrder='<option>'+code+' '+M+' '+'x'+C+' '+P+'</option>';
    $('#selOrder').append(strOrder)
    total+=P;
    $('#total').val(total);

})
.on('click','#btnCancel',function(){
    $('#selOrder').text('');
    $('#total').val('');
    total=0;
})
.on('click','#btnDone',function(){
	$('#selOrder option').each(function(){
		str=$(this).text();
		ar=str.replace('x','');
		ar=ar.split(' ');
		Phone=$('#mobile').val();
		code=ar[0];
	    Menu=ar[1];
	    Count=ar[2];
	    tprice=ar[3];
		if(Phone==''){Phone='-'};
		strDone='<option>'+code+' '+Phone+' '+Menu+' x'+Count+' '+tprice+' '+'</option>';
		$.get('sales_insert',{
			mobile:Phone,
			total:tprice,
			code:code,
			qty:Count,
			},
function(){},'text');
	    $('#selSales').append(strDone)
	});
	
    $('#selOrder').text('');
    total=0;
    $('#total,#mobile').val('');
    
    
})
.on('click','#clean',function(){
    $('#selSales').empty();
})


function summary(){
	$('#selsummary').empty();
	$.get('summary',{},function(txt){
		let rec=txt.split(';');
		for(i=0; i<rec.length; i++){
	         let field=rec[i].split(',');	        
	         let html='<option>'+field[0]+'&nbsp;/&nbsp;'+field[1]+'&nbsp;/&nbsp;'+field[2]+'&nbsp;/&nbsp;'+field[3]+'</option>';

	         $('#selsummary').append(html);
		}
	},'text');
}
function sum_cus(){
	$('#sum_customer').empty();
	$.get('cus_summary',{},function(txt){
		let rec=txt.split(';');
	
		for(i=0; i<rec.length; i++){
	         let field=rec[i].split(',');
	         let html='<option>'+field[0]+'&nbsp;/&nbsp;'+field[1]+'</option>';
	         $('#sum_customer').append(html);
	     
		}
	},'text');
}
function loadMenu(){
	   $('#selMenu,#selMenu1').empty();
	$.get('select',{},function(txt){
	      let rec=txt.split(';');
	      for(i=0; i<rec.length; i++){
	         let field=rec[i].split(',');
	         let html='<option>'+field[0]+' '+field[1]+' '+field[2]+'</option>';
	                $('#selMenu,#selMenu1').append(html);
	      }
	   },'text');
	   return false;
	}

</script>
</html>