export default {
	save() {
		console.log('Order Data: ',OrderData.orderDetails)
		let orderData = OrderData.orderDetails;
		AddOrder.run().then(res => {
			let orderId = res.length > 0 ? res[0].order_id : -1;
			console.log(orderData)
			orderData.map(async item => {
				// If component does not exist, create component
				if(item.componentId === -1){
					let res = await AddNewComponentSQL.run({
						name: item.component,
						imagename: 'image.png',
						categoryid: item.categoryId,
						boxid: item.containerId,
						description: '',
						image:  item.image,
						imagetype:'png'
					})
					item.componentId = res[0].component_id;
				}
				//Create Order
				AddComponentStock.run({
					orderid: orderId,
					componentid: item.componentId,
					quantity: item.quantity,
					unitcost: item.peritemcost,
					url: item.url
				})
			});
			showAlert(orderData.length + ' components added to DB.', 'success')
			OrderData.orderData();
			Vendor.setSelectedOption('')
		});
		return true;
	}
}