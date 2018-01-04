oldcheck = {
    title: "All except EFS, PRU, BCW: Optional if ClaimSource = C; if EpisodeSetting = I, must be after AdmissionDate; if EpisodeSetting = D, must equal AdmissionDate; If EpisodeSetting = O, H, or V, must be blank",
    f: function(e, insurer, ClaimSource, EpisodeSetting, AdmissionDate) {
        if ((insurer !== 'efs') && (insurer !== 'pru') && (insurer !== 'bcw') && ClaimSource === 'C' && !e ) throw new Error()
        if ((insurer !== 'efs') && (insurer !== 'pru') && (insurer !== 'bcw') && EpisodeSetting === 'I' && new Date(e) <= new Date(AdmissionDate) ) throw new Error()
        if ((insurer !== 'efs') && (insurer !== 'pru') && (insurer !== 'bcw') && EpisodeSetting === 'D' && new Date(e) !== new Date(AdmissionDate) ) throw new Error()
        if ((insurer !== 'efs') && (insurer !== 'pru') && (insurer !== 'bcw') && EpisodeSetting === 'O' && EpisodeSetting === 'H' && EpisodeSetting === 'V' && e != 0 ) throw new Error()
    }
}

newCheck = {
    title: "All except EFS, PRU, BCW: Optional if ClaimSource = C; if EpisodeSetting = I, must be after AdmissionDate; if EpisodeSetting = D, must equal AdmissionDate; If EpisodeSetting = O, H, or V, must be blank",
    f: function(e, insurer, ClaimSource, EpisodeSetting, AdmissionDate) {
        if ((insurer !== 'efs') && (insurer !== 'pru') && (insurer !== 'bcw')){
            if (ClaimSource === 'C' && !e ) throw new Error()
            if (EpisodeSetting === 'I' && new Date(e) <= new Date(AdmissionDate) ) throw new Error()
            if (EpisodeSetting === 'D' && new Date(e) !== new Date(AdmissionDate) ) throw new Error()
            if (EpisodeSetting === 'O' && EpisodeSetting === 'H' && EpisodeSetting === 'V' && e != 0 ) throw new Error()
        }
    }
}