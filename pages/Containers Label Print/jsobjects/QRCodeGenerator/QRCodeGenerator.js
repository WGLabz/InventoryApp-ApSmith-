export default {
	generate(id){
		const qr = qrcode(0, 'L');
		const jsonString = JSON.stringify({
			type: 'Container',
			id: id
		});
		qr.addData(jsonString);
		qr.make();
		return  qr.createDataURL(4)
	}
}