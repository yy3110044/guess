package com.yy.guess.controller;

import java.io.IOException;
import java.util.HashMap;
import javax.servlet.http.HttpServletResponse;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.yy.fast4j.Fast4jUtils;

@Controller
public class QRController {
	private static final Logger logger = LogManager.getLogger(QRController.class);

	@RequestMapping(value="/qr.png", method=RequestMethod.GET)
	public void qr(@RequestParam String url,
                   @RequestParam(defaultValue="300") int width,
                   @RequestParam(defaultValue="300") int height,
                   HttpServletResponse resp) {
		resp.setHeader("Pragma", "No-cache");
		resp.setHeader("Cache-Control", "no-cache");
		resp.setDateHeader("Expires", 0);
		HashMap<EncodeHintType, String> hints = new HashMap<EncodeHintType, String>();
		hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
		hints.put(EncodeHintType.MARGIN, "1");
		BitMatrix bitMatrix = null;
		try {
			bitMatrix = new MultiFormatWriter().encode(Fast4jUtils.urlDecode(url), BarcodeFormat.QR_CODE, width, height, hints);
			MatrixToImageWriter.writeToStream(bitMatrix, "png", resp.getOutputStream());
			resp.flushBuffer();
		} catch (WriterException | IOException e) {
			logger.error(e.toString());
		}
	}
}