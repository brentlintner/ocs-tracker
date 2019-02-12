import React from "react"
import PropTypes from "prop-types"
import Typography from "@material-ui/core/Typography"
import { withStyles } from "@material-ui/core/styles"

const styles = {}

function Content(props) {
  const { classes, component, variant, text, color } = props

  return (
    <Typography component={component} variant={variant} gutterBottom>
      {text}
    </Typography>
  )
}

Content.propTypes = {
  component: PropTypes.string,
  variant: PropTypes.string,
  text: PropTypes.string,
  color: PropTypes.string,
  classes: PropTypes.object.isRequired
}

export default withStyles(styles)(Content)
