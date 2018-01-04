package pl.edu.pwr.aerospace.rpi.utils

import java.util.BitSet
import com.pi4j.io.i2c.I2CBus
import com.pi4j.io.i2c.I2CDevice
import com.pi4j.io.i2c.I2CFactory

object LcdDriver {

	private var rsFlag: Boolean = false
	private var eFlag: Boolean = false
	private val LCD_LINE_ADDRESS: Array[Int] = Array(0x80, 0xC0, 0x90, 0xD0)
	private val rowLength = 16

	// To decide sent data is data or command
	private val LCD_CHR: Boolean = true
	private val LCD_CMD: Boolean = false

	private val BACKLIGHT: Int = 3
	private val RS_PIN: Int = 0	// Pin of MCP23017 PORTB/A connected LCD RS pin
	private val EN_PIN: Int = 2	// Pin of MCP23017 PORTB/A connected LCD E pin
	private val D7_PIN: Int = 7	// Pin of MCP23017 PORTB/A connected LCD D7 pin
	private val D6_PIN: Int = 6	// Pin of MCP23017 PORTB/A connected LCD D6 pin
	private val D5_PIN: Int = 5	// Pin of MCP23017 PORTB/A connected LCD D5 pin
	private val D4_PIN: Int = 4	// Pin of MCP23017 PORTB/A connected LCD D4 pin


	// initialization routine
	private val bus: I2CBus = I2CFactory.getInstance(I2CBus.BUS_1)
	private val dev: I2CDevice = bus.getDevice(0x27)
	lcd_byte(0x33, LCD_CMD)	// 4 bit
	lcd_byte(0x32, LCD_CMD)	// 4 bit
	lcd_byte(0x28, LCD_CMD)	// 4bit - 2 line
	lcd_byte(0x08, LCD_CMD)	// don't shift, hide cursor
	lcd_byte(0x01, LCD_CMD)	// clear and home display
	lcd_byte(0x06, LCD_CMD)	// move cursor right
	lcd_byte(0x0c, LCD_CMD)	// turn on
	write("", 0)


	// Writes a string to LCD
	def write(data: String, row: Int, column: Int): Unit = {
		// Trim the string length to prevent writing over writing over the row size
		val p = if (data.length + column > rowLength) data.substring(0, rowLength - column) else data

		setCursorPosition(row, column)
		for (i <- 0 until p.length) {
			try lcd_byte(p.charAt(i), LCD_CHR)
			catch {
				case e: Exception => e.printStackTrace()
			}
		}
	}

	// Writes a string to LCD
	def write(data: String, row: Int): Unit = {
		write(data, row, 0)
	}

	// clear and home display
	def clear(): Unit = {
		lcd_byte(0x01, LCD_CMD)
	}

	def clearRow(row: Int) : Unit = {
		write("                ", row)
	}

	// Sets RS flag and send value to ports depending on DATA or COMMAND (cmd or display data)
	private def lcd_byte(`val`: Int, `type`: Boolean): Unit = {
		rsFlag = `type`
		write(`val` >> 4)
		pulse_en(`type`, `val` >> 4)
		write(`val` & 0x0f)
		pulse_en(`type`, `val` & 0x0f)
	}

	// Convert a byte into Bitset
	private def fromByte(byt: Byte): BitSet = {
		var b = byt
		val bits: BitSet = new BitSet(8)
		for (i <- 0.until(8)) {
			bits.set(i, (b & 1) == 1)
			b = (b >> 1).asInstanceOf[Byte]
		}
		bits
	}

	// Make the enable pin high and low to provide a pulse.
	private def pulse_en(`type`: Boolean, `val`: Int): Unit = {
		eFlag = true
		write(`val`)
		eFlag = false
		write(`val`)
		if (`type` == LCD_CMD) {
			Thread.sleep(1)
		}
	}

	// Arrange the respective bit of value to be send depending upon the pins the LCD is connected to.
	private def write(incomingData: Int): Unit = {
		val tmpData: Int = incomingData
		val bits: BitSet = fromByte(tmpData.toByte)
		val out: Byte =
			((if (bits.get(3)) 1 << D7_PIN else 0) | (if (bits.get(2)) 1 << D6_PIN
			else 0) |
			  (if (bits.get(1)) 1 << D5_PIN else 0) |
			  (if (bits.get(0)) 1 << D4_PIN else 0) |
			  1 << BACKLIGHT |
			  (if (rsFlag) 1 << RS_PIN else 0) |
			  (if (eFlag) 1 << EN_PIN else 0)).toByte
		// Set the value to PORT B register.
		dev.write(0x13, out)
	}

	private def setCursorPosition(row: Int, column: Int): Unit = {
		try lcd_byte(LCD_LINE_ADDRESS(row) + column, LCD_CMD)
		catch {
			case ex: Exception => ex.printStackTrace()
		}
	}
}