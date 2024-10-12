export default {
	parseQRCode(){
		let val = CodeScanner1.value;
		try{
			let jsonData = JSON.parse(val);
			switch(jsonData.type){
				case 'box':
					navigateTo('Box',{id:jsonData.id })
					break;
			}
		}catch(e){
			showAlert(e,'error')
		}
	}
}