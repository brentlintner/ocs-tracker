import React from "react"
import PropTypes from "prop-types"
import Typography from "@material-ui/core/Typography"
import Button from "@material-ui/core/Button"
import { withStyles } from "@material-ui/core/styles"

const styles = {
  button: {
    margin: ".5rem"
  }
}

function Link(props) {
  const { classes, href, text } = props

  return (
    <Button href={href} variant="contained" className={classes.button}>
      {text}
    </Button>
  )
}

Link.propTypes = {
  href: PropTypes.string,
  text: PropTypes.string,
  classes: PropTypes.object.isRequired
}

export default withStyles(styles)(Link)
