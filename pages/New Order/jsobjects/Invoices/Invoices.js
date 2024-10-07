export default {
	async upload () {
		let description = InvoiceDescription.text;
		let date = InvoiceDate.selectedDate;
		let invoiceFiles = InvoiceFiles.files;
		let invoiceCost = InvoiceCost.value;
		let orderID = Table2.selectedRow.order_id;
		
		let fileName = InvoiceFiles.files[0].name;
		let fileType = InvoiceFiles.files[0].type;
		
		await SaveInvoiceToMinIO.run({
			filename: orderID+'_'+invoiceCost,
			content: invoiceFiles[0]
		});
		
		await AddInvoice.run({
			orderid: orderID,
			description: description,
			invoicedate: date,
			filename: fileName,
			amount: invoiceCost,
			date: new Date(),
			bucket: 'inventoryms',
			filetype: fileType
		});
	}
}