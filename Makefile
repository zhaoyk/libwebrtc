
export CROSS_COMPILE?=arm-linux-gnueabi-
export CROSS?=arm-linux-gnueabi-
export STRIP?=$(CROSS)strip
export CC:=$(CROSS)gcc
export AR:=$(CROSS)ar
export CXX:=$(CROSS)g++
  
CFLAGS := -DWEBRTC_POSIX=1 -DWEBRTC_HAS_NEON -I./jni/src/
CFLAGS += -mcpu=cortex-a7 -mfloat-abi=softfp -mfpu=neon-vfpv4 -mno-unaligned-access -fno-aggressive-loop-optimizations

CFLAGS += -std=c99
CPPFLAGS += $(CFLAGS)

SRC := \
	jni/src/webrtc/modules/audio_processing/aec/aec_core.c                    \
	jni/src/webrtc/modules/audio_processing/aec/aec_rdft.c                    \
	jni/src/webrtc/modules/audio_processing/aec/aec_resampler.c               \
	jni/src/webrtc/modules/audio_processing/aec/echo_cancellation.c           \
	jni/src/webrtc/modules/audio_processing/aecm/aecm_core.c                  \
	jni/src/webrtc/modules/audio_processing/aecm/echo_control_mobile.c        \
	jni/src/webrtc/modules/audio_processing/ns/noise_suppression.c            \
	jni/src/webrtc/modules/audio_processing/ns/noise_suppression_x.c          \
	jni/src/webrtc/modules/audio_processing/ns/ns_core.c                      \
	jni/src/webrtc/modules/audio_processing/ns/nsx_core.c                     \
	jni/src/webrtc/modules/audio_processing/utility/delay_estimator_wrapper.c \
	jni/src/webrtc/modules/audio_processing/utility/delay_estimator.c         \
	jni/src/webrtc/common_audio/fft4g.c                                       \
	jni/src/webrtc/common_audio/ring_buffer.c                                 \
	jni/src/webrtc/common_audio/signal_processing/complex_bit_reverse.c       \
	jni/src/webrtc/common_audio/signal_processing/complex_fft.c               \
	jni/src/webrtc/common_audio/signal_processing/copy_set_operations.c       \
	jni/src/webrtc/common_audio/signal_processing/cross_correlation.c         \
	jni/src/webrtc/common_audio/signal_processing/division_operations.c       \
	jni/src/webrtc/common_audio/signal_processing/downsample_fast.c           \
	jni/src/webrtc/common_audio/signal_processing/energy.c                    \
	jni/src/webrtc/common_audio/signal_processing/get_scaling_square.c        \
	jni/src/webrtc/common_audio/signal_processing/min_max_operations.c        \
	jni/src/webrtc/common_audio/signal_processing/randomization_functions.c   \
	jni/src/webrtc/common_audio/signal_processing/real_fft.c                  \
	jni/src/webrtc/common_audio/signal_processing/spl_init.c                  \
	jni/src/webrtc/common_audio/signal_processing/spl_sqrt.c                  \
	jni/src/webrtc/common_audio/signal_processing/spl_sqrt_floor.c            \
	jni/src/webrtc/common_audio/signal_processing/vector_scaling_operations.c \
	jni/src/webrtc/modules/audio_processing/aec/aec_core_neon.c               \
	jni/src/webrtc/modules/audio_processing/aec/aec_rdft_neon.c               \
	jni/src/webrtc/modules/audio_processing/aecm/aecm_core_c.c                \
	jni/src/webrtc/modules/audio_processing/aecm/aecm_core_neon.c             \
	jni/src/webrtc/modules/audio_processing/ns/nsx_core_c.c                   \
	jni/src/webrtc/modules/audio_processing/ns/nsx_core_neon.c                \
	jni/src/webrtc/common_audio/signal_processing/cross_correlation_neon.c    \
	jni/src/webrtc/common_audio/signal_processing/downsample_fast_neon.c      \
	jni/src/webrtc/common_audio/signal_processing/min_max_operations_neon.c
	

OBJ  := $(SRC:%.c=%.o)

TARGET := libwebrtc.a
.PHONY : clean all

all: $(TARGET)


%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(TARGET): $(OBJ)
	$(AR) rcs $(TARGET) $(OBJ)

clean:
	find . -name "*.o" -exec rm -rf {} \;
