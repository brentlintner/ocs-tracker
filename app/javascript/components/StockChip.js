import React from "react"
import PropTypes from "prop-types"
import { withStyles } from "@material-ui/core/styles"
import Avatar from "@material-ui/core/Avatar"
import grey from "@material-ui/core/colors/grey"

const styles = {
  stock_out: {
    color: "#FFFFFF",
    backgroundColor: grey[200],
  },
  stock_in: {
    color: "#FFFFFF",
    backgroundColor: grey[400],
  },
}

function StockChip(props) {
  const { inStock, amount, classes } = props
  if (typeof inStock == "boolean") {
    const extra_classes = inStock == true ? classes.stock_in : classes.stock_out
    return (
      <Avatar className={"card--stock--item " + extra_classes}>{amount}</Avatar>
    )
  } else {
    return null
  }
}

StockChip.propTypes = {
  inStock: PropTypes.bool,
  amount: PropTypes.string,
  classes: PropTypes.object.isRequired
}

export default withStyles(styles)(StockChip)
