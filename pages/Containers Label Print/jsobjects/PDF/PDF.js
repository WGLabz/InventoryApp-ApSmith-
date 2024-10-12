export default {
  generateLabelPDF: async () => {
    let labelWidthInches = parseFloat(Input1Copy.text);  // Convert to float for size calculation
    let labelHeightInches = parseFloat(LabelHeight.text);  // Convert to float for size calculation
    let selectedContainersArray = SelectedContainers.selectedOptionValues;

    let labelData = GetContainers.data.filter((c) => {
      return selectedContainersArray.indexOf(c.box_id) > -1;
    });

    // Load jsPDF from the CDN
    const pdf = jspdf.jsPDF({
      unit: 'in', // Use inches for measurement
      format: 'a4', // A4 format
    });

    // Get page dimensions
    const pageWidth = 8.27;
    const pageHeight = 11.69;

    // Padding between labels
    const padding = 0.1;

    // Increase the scaling factor for the QR code and font size
    const qrCodeSize = Math.min(labelWidthInches, labelHeightInches) * 0.85;  // QR code size factor
    const fontSize = Math.min(labelWidthInches, labelHeightInches) * 10;  // Font size
    const textBold = 'bold'; // Font style for bold text

    // Set the font size and bold style for the label text
    pdf.setFont('helvetica', textBold);
    pdf.setFontSize(fontSize);
    // Position coordinates
    let x = 0;
    let y = 0;

    // Loop through each label data
    for (const label of labelData) {
      if (x + labelWidthInches > pageWidth) {
        // Move to next row if label exceeds page width
        x = 0;
        y += labelHeightInches + padding;
      }

      // Generate QR code for the label (as a base64 image)
      const qrCodeImage = QRCodeGenerator.generate(label.box_id);

      // Add QR Code Image to PDF (larger size)
      pdf.addImage(qrCodeImage, 'PNG', x + padding, y + padding, qrCodeSize, qrCodeSize);  // Bigger QR code

      // Add Code Text
      pdf.text(`${label.box_code}`, x + qrCodeSize + padding * 2, y + padding + fontSize / 72);  // Adjust text positioning

      // **Text Wrapping for Label Text**:
      // Split label text into multiple lines to fit within label width
      const wrappedLabelText = pdf.splitTextToSize(`${label.box_label}`, labelWidthInches - qrCodeSize - padding * 3);
      
      // Add the wrapped text to the PDF
      pdf.text(wrappedLabelText, x + qrCodeSize + padding * 2, y + padding + (fontSize / 72) * 3);  // Text below code, with wrapping

      // Draw a rectangle around the label (optional)
      pdf.rect(x, y, labelWidthInches, labelHeightInches);

      // Move x position for the next label
      x += labelWidthInches + padding;

      // Add new page if the content exceeds the page height
      if (y + labelHeightInches > pageHeight) {
        pdf.addPage();
        x = 0;
        y = 0;
      }
    }

    // Get the base64 data for the PDF
    const base64PDF = pdf.output('datauristring');
    return base64PDF;
  }
}
