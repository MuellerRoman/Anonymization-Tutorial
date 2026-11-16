# ------------------------------------------------------------------------------
# Association heatmap for mixed variable types
#
# Computes:
# - Pearson (numeric-numeric)
# - Point-biserial (numeric-binary)
# - Cramér's V (categorical-categorical)
# - Eta (numeric-categorical)
#
# ------------------------------------------------------------------------------

assoc_heatmap <- function(df,
                          vars = NULL,
                          title = "Association heatmap",
                          limits = c(-1, 1),
                          digits = 2,
                          show_y_names = TRUE,
                          show_x_names = TRUE) {
    
    if (!is.data.frame(df)) {
        stop("df must be a data.frame")
    }
    
    if (is.null(vars)) {
        vars <- names(df)
    }
    
    df <- df[, vars, drop = FALSE]
    
    # Type helpers ----
    
    as_cat <- function(v) {
        if (is.factor(v)) return(v)
        if (is.logical(v)) return(factor(v, levels = c(FALSE, TRUE)))
        if (is.character(v)) return(factor(v))
        v
    }
    
    is_num <- function(v) is.numeric(v) || is.integer(v)
    is_bin <- function(v) {
        v <- as_cat(v)
        is.factor(v) && nlevels(v) == 2
    }
    
    is_nom <- function(v) {
        v <- as_cat(v)
        is.factor(v) && nlevels(v) > 2
    }
    
    # Association measures ----
    
    cramers_v <- function(x, y) {
        x <- as_cat(x)
        y <- as_cat(y)
        
        tab <- table(x, y)
        if (any(dim(tab) < 2)) return(NA_real_)
        chi2 <- suppressWarnings(chisq.test(tab, correct = FALSE)$statistic)
        
        n <- sum(tab)
        k <- min(nrow(tab) - 1L, ncol(tab) - 1L)
        if (k <= 0L) return(NA_real_)
        
        as.numeric(sqrt(chi2 / (n * k)))
    }
    
    eta <- function(y, x) {
        x <- as_cat(x)
        ok <- complete.cases(y, x)
        y <- y[ok]
        x <- x[ok]
        
        if (length(y) < 2L || nlevels(x) < 2L) return(NA_real_)
        
        grand_mean <- mean(y)
        ss_total <- sum((y - grand_mean)^2)
        if (ss_total <= 0) return(NA_real_)
        
        means <- tapply(y, x, mean)
        ns    <- tapply(y, x, length)
        ss_between <- sum(ns * (means - grand_mean)^2)
        
        sqrt(ss_between / ss_total)
    }
    
    # Build association matrix ----
    
    p <- length(vars)
    out <- matrix(NA_real_, p, p, dimnames = list(vars, vars))
    
    for (i in seq_len(p)) {
        for (j in seq_len(p)) {
            
            vi <- df[[i]]
            vj <- df[[j]]
            
            vi_cat <- as_cat(vi)
            vj_cat <- as_cat(vj)
            
            if (i == j) {
                out[i, j] <- 1
                next
            }
            
            # numeric-numeric: Pearson
            if (is_num(vi) && is_num(vj)) {
                out[i, j] <- suppressWarnings(
                    cor(vi, vj, method = "pearson",
                        use = "pairwise.complete.obs")
                )
                next
            }
            
            # numeric-binary: point-biserial (Pearson with 0/1)
            if (is_num(vi) && is_bin(vj_cat)) {
                out[i, j] <- suppressWarnings(
                    cor(vi, as.integer(vj_cat) - 1L,
                        method = "pearson",
                        use = "complete.obs")
                )
                next
            }
            if (is_bin(vi_cat) && is_num(vj)) {
                out[i, j] <- suppressWarnings(
                    cor(as.integer(vi_cat) - 1L, vj,
                        method = "pearson",
                        use = "complete.obs")
                )
                next
            }
            
            # categorical-categorical
            if ((is_nom(vi_cat) || is_bin(vi_cat)) &&
                (is_nom(vj_cat) || is_bin(vj_cat))) {
                out[i, j] <- cramers_v(vi_cat, vj_cat)
                next
            }
            
            # numeric-nominal
            if (is_num(vi) && (is_nom(vj_cat) || is_bin(vj_cat))) {
                out[i, j] <- eta(vi, vj_cat)
                next
            }
            if ((is_nom(vi_cat) || is_bin(vi_cat)) && is_num(vj)) {
                out[i, j] <- eta(vj, vi_cat)
                next
            }
        }
    }
    
    # Plot heatmap ----
    
    p <- nrow(out)
    
    pal <- colorRampPalette(c("#B2182B", "#F7F7F7", "#2166AC"))(201)
    
    # symmetric limits around 0 so 0 -> white
    m <- max(abs(out), na.rm = TRUE)
    limits <- c(-m, m)
    
    # orient z for base::image so that cell colors align with out[i,j]
    # - transpose because image() treats matrix orientation differently
    # - reverse rows in the plotted view so the first variable is at the top
    z_img <- t(out)[, p:1, drop = FALSE]
    
    # make mapping deterministic
    brks <- seq(limits[1], limits[2], length.out = length(pal) + 1)
    
    image(
        x = 1:p, y = 1:p, z = z_img,
        col = pal, breaks = brks,
        axes = FALSE, xlab = "", ylab = "",
        main = title,
        xlim = c(0.5, p + 0.5),
        ylim = c(0.5, p + 0.5),
        xaxs = "i", yaxs = "i"
    )
   
    # draw axis
    axis(
        1, at = 1:p,
        labels = if (show_x_names) colnames(out) else rep("", p),
        las = 2, cex.axis = 0.8, tick = FALSE
    )
    
    axis(
        2, at = 1:p,
        labels = if (show_y_names) rev(rownames(out)) else rep("", p),
        las = 2, cex.axis = 0.8, tick = FALSE
    )
    
    # add values: map matrix row i to plot y = p - i + 1
    for (i in 1:p) {
        for (j in 1:p) {
            val <- out[i, j]
            if (!is.na(val)) {
                text(j, p - i + 1, sprintf(paste0("%.", digits, "f"), val), cex = 0.65)
            }
        }
    }
    
    box()
}
