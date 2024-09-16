import { Box } from '@mui/material'
import Image from 'next/image'
import { styles } from '@/styles'

const Loading = () => {
  return (
    <Box
      css={styles.pageMInHeight}
      sx={{
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
      }}
    >
      <Image src="/loading.svg" width={150} height={50} alt="Loading..." />
    </Box>
  )
}

export default Loading
