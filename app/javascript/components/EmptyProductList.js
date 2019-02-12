import React from "react"
import PropTypes from "prop-types"
import { withStyles } from "@material-ui/core/styles"
import Typography from "@material-ui/core/Typography"
import SentimentDissatisfiedIcon from "@material-ui/icons/SentimentDissatisfied"

const styles = theme => ({
  root: {
    textAlign: "center",
    height: "70vh",
    display: "flex",
    alignItems: "center",
    flexDirection: "column",
    justifyContent: "center"
  },
  icon: {
    color: "#AAAAAA",
    margin: 0
  },
  paragraph: {
    marginTop: "1rem",
    color: "#AAAAAA"
  }
})

function EmptyProductList(props) {
  const { classes } = props
  return (
    <div className={classes.root}>
      <SentimentDissatisfiedIcon className={classes.icon} fontSize="large">
      </SentimentDissatisfiedIcon>
      <Typography component="p" variant="body1" className={classes.paragraph} gutterBottom>
        Nothing to see here.
      </Typography>
    </div>
  )
}

EmptyProductList.propTypes = {
  classes: PropTypes.object.isRequired,
}

export default withStyles(styles)(EmptyProductList)
