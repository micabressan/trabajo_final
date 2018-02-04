import org.apache.commons.lang3.ClassUtils;
import org.apache.commons.lang3.builder.RecursiveToStringStyle;
import org.apache.commons.lang3.builder.ReflectionToStringBuilder;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CustomToStringStyle extends RecursiveToStringStyle {

    /**
     * Required for serialization support.
     * @see java.io.Serializable
     */
    private static final long serialVersionUID = 1L;

    /** Indenting of inner lines. */
    private static final int INDENT = 2;

    /** Current indenting. */
    private int spaces = 2;

    /**
     * Constructor.
     */
    public CustomToStringStyle() {
        super();
        resetIndent();
        this.setUseClassName(false);
        this.setUseIdentityHashCode(false);
        this.setFieldNameValueSeparator(": ");
        this.setNullText("null");
    }

    private void resetIndent() {
        setArrayStart("\n" + spacer(spaces));
        setArraySeparator("," + spacer(spaces));
        setArrayEnd("");

        setContentStart("\n" + spacer(spaces));
        setFieldSeparator("\n" + spacer(spaces));
        setContentEnd("");
    }

    private StringBuilder spacer(final int spaces) {
        final StringBuilder sb = new StringBuilder();
        for (int i = 0; i < spaces; i++) {
            sb.append(" ");
        }
        return sb;
    }

    @Override
    public void appendDetail(final StringBuffer buffer, final String fieldName, final Object value) {
        if (!ClassUtils.isPrimitiveWrapper(value.getClass()) && !String.class.equals(value.getClass())
                && accept(value.getClass())) {
            spaces += INDENT;
            resetIndent();
            buffer.append(ReflectionToStringBuilder.toString(value, this));
            spaces -= INDENT;
            resetIndent();
        }

        else {
            super.appendDetail(buffer, fieldName, value);
        }
    }

    @Override
    protected void appendDetail(final StringBuffer buffer, final String fieldName, final Object[] array) {
        spaces += INDENT;
        resetIndent();
        super.appendDetail(buffer, fieldName, array);
        spaces -= INDENT;
        resetIndent();
    }

    @Override
    protected void reflectionAppendArrayDetail(final StringBuffer buffer, final String fieldName, final Object array) {
        spaces += INDENT;
        resetIndent();
        super.reflectionAppendArrayDetail(buffer, fieldName, array);
        spaces -= INDENT;
        resetIndent();
    }


    protected void appendDetail(final StringBuffer buffer, final String fieldName, final Date value) {
        if (value instanceof Date) {
             String dateValue = new SimpleDateFormat("yyyy-MM-dd").format(value);
            super.appendDetail(buffer, fieldName, dateValue);}
    }
}